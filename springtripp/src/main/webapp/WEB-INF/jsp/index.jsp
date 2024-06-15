<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
  <title>Главная</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
  <script src="https://api-maps.yandex.ru/2.1/?lang=ru_RU&amp;apikey=de83cffa-bcfb-4125-b9f1-f6ba8053ae08" type="text/javascript"></script>
  <style>
    body, html {
         margin: 0;
         padding: 0;
         height: 100%;
       }

        /* Стиль для верхней панели */
           header {
             background-color: #ffd800;
             padding: 10px;
             display: flex; /* Используем flexbox для размещения элементов в строку */
             justify-content: space-between; /* Равномерно распределяем элементы */
             position: fixed;
             top: 0;
             left: 0;
             width: 100%;
             z-index: 100;
             box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
             padding-right: 200px;


           }
           /* Стиль для ссылки на новости */
           header a {
             margin: 0 10px;
             text-decoration: none; /* Убираем подчеркивание */
             color: #ffd800; /* Темно-серый цвет */
           }
           header h4 a[href="/news"] {
           margin-right: 50px; /* Отступ справа от ссылки */
           }
           header h1, header h3, header h4, header a {
             color: #000000; /* Черный цвет текста */
           }
           /* Стиль для выпадающего списка */
           .suggestions {
             list-style: none;
             padding: 0;
             position: absolute;
             z-index: 10;
             background-color: white;
             box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
             display: none;
           }

           .suggestions li {
             padding: 10px;
             cursor: pointer;
           }

           .suggestions li:hover {
             background-color: #f0f0f0;
           }
       /* Стиль для карты */
       #map {
         position: absolute;
         top: 60px; /* Отступ для верхней панели */
         left: 0;
         width: 100%;
         height: calc(100% - 60px); /* Вычитаем высоту верхней панели */
       }

        /* Стиль для формы */
           .order-form {
             position: absolute;
             top: 50%;
             left: 50%;
             transform: translate(-50%, -50%);
             background-color: white;
             padding: 20px;
             border-radius: 5px;
             box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
             z-index: 100; /* Важно: чтобы форма была над картой */
             width: 400px; /* Задайте ширину формы */
             max-width: 90%; /* Ограничьте ширину на маленьких экранах */
           }

           .order-form label {
             display: block;
             margin-bottom: 5px;
           }

           .order-form input {
             width: 100%;
             padding: 10px;
             margin-bottom: 10px;
             border: 1px solid #ccc;
             border-radius: 3px;
           }

           .order-form select {
             width: 100%;
             padding: 10px;
             margin-bottom: 10px;
             border: 1px solid #ccc;
             border-radius: 3px;
           }

           .order-form button {
             background-color: #ffd800;
             color: black;
             padding: 10px 20px;
             border: none;
             border-radius: 3px;
             cursor: pointer;
           }
  </style>
</head>
<body>
    <header>
      <h1>SpringTrip</h1>
      <sec:authorize access="isAuthenticated()">
        <h3>${pageContext.request.userPrincipal.name}</h3>
        <h4><a href="/logout">Выйти</a></h4>
      </sec:authorize>
      <sec:authorize access="!isAuthenticated()">
        <h4><a href="/login">Войти</a></h4>
        <h4><a href="/registration">Зарегистрироваться</a></h4>
      </sec:authorize>
      <h4><a href="/news">Новости</a></h4>

      <sec:authorize access="hasRole('ADMIN')">
        <h4><a href="/admin">Пользователи</a></h4>
        &nbsp;
      </sec:authorize>
    </header>
    <div id="map"></div>

  <!-- Форма оформления заказа -->
  <div class="order-form">
    <h2>Заказать такси</h2>
    <script>
            // JavaScript for handling form submission and redirection
            document.addEventListener('DOMContentLoaded', function() {
                const orderForm = document.getElementById('orderForm');

                orderForm.addEventListener('submit', function(event) {
                    event.preventDefault(); // Prevent default form submission

                    // You can add validation here if needed

                    // Send form data using AJAX (optional)

                    // Redirect to order confirmation page after successful submission
                    window.location.href = "/order-confirmation";
                });
            });
        </script>
    <form th:action="@{/order}" th:object="${order}" method="post">
      <div>
        <label for="from-address">Откуда:</label>
        <input type="text" id="from-address" name="fromAddress">
        <ul id="from-address-suggestions"></ul>
      </div>
      <div>
        <label for="to-address">Куда:</label>
        <input type="text" id="to-address" name="toAddress">
        <ul id="to-address-suggestions"></ul>
      </div>
       <div>
      <label for="car_type">Тип тарифа:</label>
      <select th:field="*{carType}" id="car_type">
          <option th:each="type : ${carTypes}" th:value="${type}" th:text="${type}"></option>
           <option value="SEDAN">Седан</option>
           <option value="SUV">Внедорожник</option>
           <option value="SPORTS_CAR">Спортивный автомобиль</option>
      </select>
      </div>
 <div>
      <label for="paymentMethod">Способ оплаты:</label>
       <select th:field="*{paymentMethod}" id="paymentMethod">
                <option th:each="method : ${paymentMethods}" th:value="${method}" th:text="${method}"></option>
        <option value="CREDIT_CARD">Кредитная карта</option>
        <option value="PAYPAL">PayPal</option>
        <option value="BANK_TRANSFER">Банковский перевод</option>
      </select>
      </div>
      <form id="orderForm" method="POST" action="/">
        <button type="submit">Заказать</button>
    </form>
  </div>

  <script>
    ymaps.ready(init);

    var map, myPlacemarks = [], myRoute;

    function init() {
      // Создаем карту
      map = new ymaps.Map('map', {
        center: [53.2004, 50.1083],
        zoom: 11
      });

      // Обработчик выбора адресов
      document.getElementById('from-address').addEventListener('input', function () {
        updateSuggestions('from-address');
      });

      document.getElementById('to-address').addEventListener('input', function () {
        updateSuggestions('to-address');
      });

      // Построение маршрута при изменении адресов
      document.getElementById('from-address').addEventListener('change', buildRoute);
      document.getElementById('to-address').addEventListener('change', buildRoute);
    }
     // Функция получения предложений адресов от Yandex.Maps API
        // Ограничивает поиск пределами Самары
        function getSuggestions(query) {
          const samaraBounds = [
            [53.1372, 49.8747], // South-West
            [53.3396, 50.3803] // North-East
          ];
return new Promise((resolve, reject) => {
        ymaps.geocode(query, {
          results: 5, // Limit to 5 results
          boundedBy: samaraBounds // Search within Samara bounds
        })
          .then(res => {
            if (res.geoObjects.getLength() > 0) {
              const suggestions = res.geoObjects.toArray().map(geoObject => {
                return geoObject.properties.get('text');
              });
              resolve(suggestions);
            } else {
              reject('No suggestions found within Samara.');
            }
          })
          .catch(err => {
            reject(err);
          });
      });
    }

    // Функция получения предложений адресов от Yandex.Maps API
    function getSuggestions(query) {
      return new Promise((resolve, reject) => {
        ymaps.geocode(query, { results: 5 })
          .then(res => {
            if (res.geoObjects.getLength() > 0) {
              const suggestions = res.geoObjects.toArray().map(geoObject => {
                return geoObject.properties.get('text');
              });
              resolve(suggestions);
            } else {
              reject('No suggestions found');
            }
          })
          .catch(err => {
            reject(err);
          });
      });
    }

    // Функция обновления списка предложений
    function updateSuggestions(id) {
      const inputValue = document.getElementById(id).value.trim();
      const suggestionsList = document.getElementById(id + '-suggestions');

      if (inputValue.length >= 3) {
        getSuggestions(inputValue)
          .then(suggestions => {
            suggestionsList.innerHTML = '';

            suggestions.forEach(suggestion => {
              const li = document.createElement('li');
              li.textContent = suggestion;
              li.addEventListener('click', function () {
                document.getElementById(id).value = suggestion;
                suggestionsList.style.display = 'none';
              });
              suggestionsList.appendChild(li);
            });

            suggestionsList.style.display = 'block';
          })
          .catch(error => {
            suggestionsList.innerHTML = '<li>No suggestions found</li>';
            suggestionsList.style.display = 'block';
          });
      } else {
        suggestionsList.style.display = 'none';
      }
    }

    // Функция построения маршрута
    function buildRoute() {
      // Удаляем предыдущий маршрут
      if (myRoute) {
        myRoute.setMap(null);
      }

      const from = document.getElementById('from-address').value;
      const to = document.getElementById('to-address').value;

      if (from && to) {
        ymaps.route([from, to])
          .then(route => {
            myRoute = route.getPaths();
            myRoute.getMap(map); // Set the route on the map
          })
          .catch(error => {
            console.error('Error building route:', error);
          });
      }
    }
  </script>
</body>
</html>
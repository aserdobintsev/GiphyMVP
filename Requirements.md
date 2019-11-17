# Техническое задание к тестовому проекту
 
## Общие требования
* Использование сторонних библиотек: приветствуется использование Realm (но не обязательно). Использование остальных библиотек потребуется обосновать на собеседовании.
* Внешнее и внутреннее качество должно соответствовать реальному крупному
проекту.
* Если для качественной реализации какой либо части требуется достаточно много
времени, которого у Вас нет, то следует оставить комментарий к коду (​// TODO: ...)​или в файле “​TODO.md”​в корне репозитория, как именно желательно реализовать эту часть приложения.
* В качестве источника данных использовать любое открытое API (со списком открытых API можно ознакомиться з​десь)​.
* Предметная область выбирается на усмотрение исполнителя.
* Code Style описан з​десь

## Нефункциональные требования
* Поддержка версий iOS: 9.0 в портретной и ландшафной ориентациях;
* Поддержка устройств: iPhone;
* Поддерживаемые языки: русский, английский;
* Язык реализации: Swift 3 или выше;
* Приложение должно быть построено согласно паттерну MVP.

## Глоссарий
* Тап – нажатие на элемент.
* Pull-to-refresh – движение потягивания контентной части экрана из-под верхнего
навигационного меню, используемое для обновления экрана.
* Progress indicator – индикатор активности выполнения какого-либо действия в
приложении.
* Footer – последний элемент списка, обычно отличается от предыдущих элементов
* Объект – некоторая сущность из выбранной кандидатом предметной области.
Например, если в качестве источника было выбрано API для работы с базой данных фильмов, то объектом может быть фильм. Следовательно справочное приложение должно предоставлять пользователю возможность просматривать список фильмов и смотреть детальную информацию о фильме. Поисковое приложение будет давать пользователю возможность смотреть список фильмов и осуществлять поиск по базе данных фильмов.

## Экран списка объектов
Экран содержит список объектов из выбранной кандидатом предметной области с возможностью поиска.
Объекты можно добавлять в избранное, можно осуществлять поиск объектов. Название объекта может занимать до 2-х строк. Описание занимает все оставшееся пространство между названием и кнопкой добавления в избранное. Если название или описание не помещается, то они должны заканчиваться троеточием.
Элемент списка следует реализовать таким образом, чтобы его легко можно было переиспользовать на других экранах.

### Дополнительные состояния
1. Progress indicator при загрузке данных, когда нет контента для отображения
2. Пустая выдача.
3. Ошибка загрузки данных, когда нет контента для отображения.
4. Progress indicator при загрузке данных, когда есть контент для отображения.

### Pull-to-refresh
На экране должна присутствовать логика обновления через Pull-to-refresh. Pull-to-refresh доступен во всех состояниях где есть контент.

### Пагинация
Данные загружаются порционно по 20 элементов. Для индикации загрузки следующего блока данных используется Footer с Progress indicator. В случае ошибки загрузки следующего блока данных вместо Footer с Progress indicator показывается Footer с кнопкой при тапе на которую происходит повторная загрузка следующего блока данных. При успешной загрузке последней порции данных Footer с Progress indicator должен отсутствовать.

### Обработка ошибок
В случае любой ошибки загрузки данных показывается сообщение об ошибке “Проверьте соединение с интернетом и попробуйте еще раз”. Дополнительные способы отображения ошибок описаны в предыдущих пунктах.

### Добавление в избранное
Состояние избранности товаров сохраняется локально и не должно сбрасываться при перезапуске приложения.

### Поиск
Фильтрация производится по поисковой строке. При пустой поисковой строке должна отображаться история прошлых поисковых запросов. При вводе более 3-х символов необходимо делать запрос на сервер и отображать список вернувшихся объектов. Для реализации рекомендуется использовать SearchController.

### Смена ориентации экрана
При смене ориентации экрана не должен выполняться повторный запрос данных, позиция списка должна сохраняться. Объекты должны показываться в два столбца.
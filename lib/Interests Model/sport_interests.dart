class SportInterests{

  static SportInterests? _instance;

  static SportInterests init() {
    if(_instance != null){
      return _instance!;
    }else{
      return _instance = SportInterests();
    }
  }

  final List<String> _sportInterests = [
    'Игровые',
    'Циклические',
    'Сложнокоординационные',
    'Силовые',
    'Единоборства',
    'Технические',
    'Авиационные',
    'Экстремальные',
    'Прикладные',
    'Ациклические',
    'Индивидульные',
    'Футбол  ⚽️',
    'Баскетбол  🏀',
    'Крикет🏏',
    'Теннис🎾',
    'Легкая атлетика🏃',
    'Регби🏉',
    'Бокс🥊',
    'Хоккей🏒',
    'Волейбол 🏐',
    'Гольф⛳🏌',
    'Бейсбол⚾',
    'Бадминтон🏸',
    'Велосипед🚲',
    'Плавание 🏊',
    'Биатлон🎿',
    'Горные лыжи ⛷',
    'Сноуборд 🏂',
    'Фитнес',
    'Триатлон🚴',
    'Гимнастика 🤸',
    'Йога🧘',
    'Аэробика',
    'Шашки ',
    'Шахматы♟',
    'Танцы💃',
    'Акробатика 🤸',
    'Тяжелая атлетика 🏋',
    'Каратэ 🥋',
    'Дзюдо 🥋',
    'Бодибилдинг 🏋',
    'Самбо 🤼',
    'Пауэрлифтинг 🏋',
    'Стрельба из лука🏹',
    'Скейтборд🛹',
    'Конный спорт🏇',
    'Серфинг🏄',
    'Спортивная борьба 🤼',
    'Скалолазание 🧗',
    'Гиревой спорт🏋',
    'Тхэквондо 🥋',
    'Бадминтон 🏸',
    'Бильярд🎱',
    'Боулинг 🎳',
    'Американский футбол🏈',
    'Рукопашный бой🤼‍♂️',
    'Армспорт 💪',
    'Гребля🚣‍♀️',
    'Хоккей на траве🏑',
    'Компьютерный спорт💻',
    'Джиу-джитсу',
    'Фигурное катание ⛸',
    'ВМХ🚲',
    'Яхтинг⛵',
    'Кикбоксинг 🥊',
    'Автоспорт🏎',
    'Мотоциклы🏍',
    'Батут',
    'Пейнтбол ',
    'Паркур',
    'Дайвинг🤿',
    'Фехтование 🤺',
    'Парашют🪂',
    'Дельтаплан',
    'Дартс 🎯',
    'Водное поло🤽',
    'Кёрлинг🥌',
    'Бобслей',
    'Блицспринт',
    'Лапта ',
    'Прыжки в воду',
    'Черлидинг',
    'Тайский бокс',
    'Гандбол🤾',
    'Стрельба из лука🏹',
    'Санный спорт',
    'Полиатлон ',
    'Айкидо',
    'Сумо ',
    'Кудо',
    'Ушу ',
    'Вейкборд',
    'Флорбол ',
    'Маунтинбайк',
    'Роллер спорт',
    'Радиоспорт ',
    'Сквош',
    'Тюбинг ',
    'Скелетон',
    'Сэндбординг',
    'Акватлон',
    'Шорт-трек ',
    'Мас-рестлинг',
    'Го ',
    'Кёкусинкай',
    'Снукер',
    'Бочча',
    'Корфбол',
    'Рафтинг',
    'Ракетбол',
    'Регбол',
    'Софтбол',
    'Чанбара ',
    'Панкратион',
    'Рингетт',
    'Кайтселинг',
    'Ледолазание',
    'Карвинг',
    'Скиборд',
  ];


  List<String> getSportInterests() => _sportInterests;
}
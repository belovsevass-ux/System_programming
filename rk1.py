from operator import itemgetter

class Microprocessor:
    """Микропроцессор"""
    def __init__(self, id, model, cores, freq):
        self.id = id
        self.model = model
        self.cores = cores
        self.freq = freq

class Computer:
    """Компьютер"""
    def __init__(self, id, name, price, mp_id):
        self.id = id
        self.name = name
        self.price = price
        self.mp_id = mp_id

class CompMp:
    """Компьютеры и Микропроцессоры (связь многие-ко-многим)"""
    def __init__(self, comp_id, mp_id):
        self.comp_id = comp_id
        self.mp_id = mp_id

# Микропроцессоры
mps = [
    Microprocessor(1, 'Intel Core i5', 4, 2.5),
    Microprocessor(2, 'AMD Ryzen 7', 8, 3.6),
    Microprocessor(3, 'Apple M1', 8, 3.2),
    Microprocessor(4, 'Intel Core i9', 12, 4.0),
]

# Компьютеры
comps = [
    Computer(1, 'Офисный ПК', 50000, 1),
    Computer(2, 'Игровой ПК', 150000, 4),
    Computer(3, 'Рабочая станция', 120000, 2),
    Computer(4, 'Ноутбук', 60000, 3),
    Computer(5, 'Домашний ПК', 80000, 2),
]

comps_mps = [
    CompMp(1, 1),
    CompMp(2, 4),
    CompMp(3, 2),
    CompMp(4, 3),
    CompMp(5, 2),
]

def main():
    # Соединение данных один-ко-многим
    one_to_many = [(c.name, c.price, m.model) 
                   for m in mps 
                   for c in comps 
                   if c.mp_id == m.id]

    # Соединение данных многие-ко-многим
    many_to_many_temp = [(c.name, cm.mp_id, cm.comp_id) 
                         for c in comps 
                         for cm in comps_mps 
                         if c.id == cm.comp_id]
    
    many_to_many = [(c.name, c.price, m.model) 
                    for m in mps 
                    for comp_name, mp_id, comp_id in many_to_many_temp 
                    if m.id == mp_id 
                    for c in comps if c.id == comp_id]

    print('Задание Д1')
    # В примере искали фамилию на "ов", у нас названия ПК на "ПК"
    res_11 = [(c[0], c[2]) for c in one_to_many if c[0].endswith('ПК')]
    res_11 = sorted(res_11, key=itemgetter(0))
    print(res_11)

    print('\nЗадание Д2')
    res_12_unsorted = []
    # Перебираем все микропроцессоры
    for m in mps:
        # Список компьютеров на этом процессоре
        m_comps = list(filter(lambda i: i[2] == m.model, one_to_many))
        # Если процессор используется
        if len(m_comps) > 0:
            # Цены компьютеров
            m_prices = [price for _, price, _ in m_comps]
            # Средняя цена (сумма / количество)
            m_avg_price = sum(m_prices) / len(m_prices)
            res_12_unsorted.append((m.model, m_avg_price))
            
    # Сортировка по средней цене
    res_12 = sorted(res_12_unsorted, key=itemgetter(1))
    print(res_12)

    print('\nЗадание Д3')
    res_13 = {}
    # Перебираем все микропроцессоры
    for m in mps:
        if m.model.startswith('A'):
            # Список компьютеров для этого процессора (связь многие-ко-многим)
            m_comps = list(filter(lambda i: i[2] == m.model, many_to_many))
            # Только названия компьютеров
            m_comp_names = [x for x, _, _ in m_comps]
            # Добавляем результат в словарь
            # ключ - процессор, значение - список названий ПК
            res_13[m.model] = m_comp_names

    print(res_13)

if __name__ == '__main__':
    main()
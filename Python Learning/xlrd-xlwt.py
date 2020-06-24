import xlrd
import xlwt


def excel_read(file_path):
    data = xlrd.open_workbook(file_path)
    table = data.sheet_by_index(0)
    res = []
    where = ' '
    for r in range(1, table.nrows):
        point = []
        for c in range(1, table.ncols):
            point.append(str(table.cell(r, c).value))
        if point[-1] != where:
            where = point[-1]
            res.append(point)
    return res


def excel_write(save_path, res):
    workbook = xlwt.Workbook(encoding = 'utf-8')
    worksheet = workbook.add_sheet('sheet1')

    worksheet.write(0, 0, label = 'x')
    worksheet.write(0, 1, label = 'y')
    worksheet.write(0, 2, label = 'value')
    worksheet.write(0, 3, label = 'type')
    for i in range(len(res)):
        for j in range(len(res[0])):
            worksheet.write(i+1, j, label = res[i][j])

    workbook.save(save_path)
    return save_path


if __name__ == '__main__':
    excel_write(r'', excel_read(r''))
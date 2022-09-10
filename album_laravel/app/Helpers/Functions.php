<?php

if (!function_exists('search')) {
    /**
     * 模型搜索通用方法 (列表数据)
     * @param $model
     * @param array $fieldMaps eg: [ 'uid', 'status' => 'like', ] // 默认uid的值处理为 equal
     * @param string $sortField 默认排序字段
     * @param string $sortType 默认排序类型
     * @return mixed
     * @throws Exception
     */
    function search($model, $fieldMaps = [], $sortField = 'created_at', $sortType = 'DESC')
    {
        if (is_string($model)) {
            $model = new $model;
        }

        // 字段搜索
        // 对每个字段进行搜索, 字段值为 空字符串 则跳过
        foreach ($fieldMaps as $field => $type) {
            if (is_int($field)) {
                $field = $type;
                $type = 'equal';
            }

            $value = request($field, '');
            if ($value === '') {
                continue;
            }

            switch ($type) {
                case 'equal' :
                    $model = $model->where($field, $value);
                    break;
                case 'like' :
                    $model = $model->where($field, 'like', "%{$value}%");
                    break;
                default:
                    throw new Exception("未知查询类型: {$type}");
            }
        }

        // 字段排序
        $sort = request('sort', '');
        if (!empty($sort)) {
            $sortField = substr($sort, 1);
            $sortType = substr($sort, 0, 1) === '+' ? 'ASC' : 'DESC';
        }

        $model = $model->orderBy($sortField, $sortType);
        return $model;
    }
}

/**
 * 分页用
 */
if (!function_exists('paginate')) {
    function paginate($model, $fieldMaps = [], $sortField = 'created_at', $sortType = 'DESC') {
        $page = request('limit', 10);

        return search($model, $fieldMaps, $sortField, $sortType)->paginate($page);
    }
}

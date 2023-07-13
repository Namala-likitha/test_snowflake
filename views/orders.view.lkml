view: orders {
  sql_table_name: "LOOKER_TEST"."ORDERS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: date{
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  parameter: day_interval {
    type: number
  }


  dimension: order_amount {
    type: number
    sql: ${TABLE}."ORDER_AMOUNT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  measure: trillion {
    label: "Market Value"
    type: sum
    sql:    1000000000000*2;;
    value_format: "#,##0.00"
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.name,
      users.id,
      billion_orders.count,
      hundred_million_orders.count,
      order_items.count
    ]
  }
}

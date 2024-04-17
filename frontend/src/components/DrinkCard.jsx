import { Card } from "flowbite-react";
import React from "react";

const DrinkCard = () => {
  return (
    <Card className="max-w-sm" imgAlt="Drink Image" imgSrc="img/drinks/1.jpg">
      <a href="#">
        <h5 className="text-xl font-semibold tracking-tight text-gray-900 dark:text-white">
          Americano
        </h5>
      </a>
      <div className="flex items-center justify-between">
        <span className="text-3xl font-bold text-gray-900 dark:text-white">
          20.000 VND
        </span>
        <a
          href="#"
          onClick={() => {
            alert("Đã thêm vào giỏ hàng");
          }}
          className="rounded-lg bg-cyan-700 px-5 py-2.5 text-center text-sm font-medium text-white hover:bg-cyan-800 focus:outline-none focus:ring-4 focus:ring-cyan-300 dark:bg-cyan-600 dark:hover:bg-cyan-700 dark:focus:ring-cyan-800"
        >
          Chọn
        </a>
      </div>
    </Card>
  );
};

export default DrinkCard;

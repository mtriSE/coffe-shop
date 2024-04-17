import React from "react";
import { Link } from "react-router-dom";

const PromoCard = () => {
  return (
    <Link className="flex gap-8 rounded-xl" to={"#"}>
      <img
        className="rounded-xl"
        src="img/promos/1.webp"
        alt="Promo Image"
        width={250}
        height={250}
      />
      <div className="flex flex-col gap-2">
        <div className="text-lg font-semibold">Tên khuyến mãi</div>
        <div className="text-base">Tóm tắt khuyến mãi các thứ</div>
      </div>
    </Link>
  );
};

export default PromoCard;

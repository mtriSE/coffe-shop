import PromoCard from "@components/PromoCard";
import React from "react";

const Promos = () => {
  return (
    <div className="flex flex-col gap-8 py-4">
      <PromoCard />
      <PromoCard />
      <PromoCard />
      <PromoCard />
      <PromoCard />
    </div>
  );
};

export default Promos;
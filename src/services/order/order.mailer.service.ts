import { MailerService } from "@nestjs-modules/mailer";
import { Injectable } from "@nestjs/common";
import { MailConfig } from "config/mail.config";
import { CartArticle } from "src/entities/cart-article.entity";
import { Order } from "src/entities/order.entity";

@Injectable()
export class OrderMailer {
    constructor(private readonly mailService: MailerService) { }

    async sendOrderEmail(order: Order) {
        await this.mailService.sendMail({
            to: order.cart.user.email, // Kome se salje
            bcc: MailConfig.orderNotificationMail, // Kome se salje da je porudzbina napravljena
            subject: 'Detalji Vase porudzbine',
            encoding: 'UTF-8',
            // replyTo: 'no-relpay@domain.com' Ako ne zelimo da korisnik uradi Replay nase poruke
            html: this.makeOrderHtml(order),
        });
    }

    private makeOrderHtml(order: Order): string {
        let suma = order.cart.cartArticles.reduce((sum, current: CartArticle) => {
            return sum +
                   current.quantity *
                   current.article.articlePrices[current.article.articlePrices.length - 1].price
        }, 0);
        return `<p>Hvala na porudzbini.</p>
                <p>Ovo su detalji Vase porudzbine:</p>
                <ul>
                    ${ order.cart.cartArticles.map((cartArticle: CartArticle) => {
                        return `<li>
                            ${ cartArticle.article.name } x
                            ${ cartArticle.quantity }
                        </li>`
                    }).join("") }
                </ul>
                <p>Ukupan iznos je: ${ suma } EUR.</p>
                <p>Vasa Online prodavnica racunara i telefona</p>
                `;
    }
}
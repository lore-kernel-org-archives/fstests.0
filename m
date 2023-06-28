Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEC6EB64DC
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Jun 2023 10:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjF1K1N (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Jun 2023 06:27:13 -0400
Received: from forward501a.mail.yandex.net ([178.154.239.81]:42644 "EHLO
        forward501a.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231545AbjF1KZN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Jun 2023 06:25:13 -0400
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id A60445E78A;
        Wed, 28 Jun 2023 13:25:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6PJoVD9DeGk0-VqQcWTyP;
        Wed, 28 Jun 2023 13:25:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687947907;
        bh=aSY9y8rIqEBr7+mmPC2d1uHL73lnoI3fdXJwRTWU8E0=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=iBTG5460XSKO0zyfkTrUQIuoFFLHyHiWZKd2YrspXALh8IYRcOBP8U4iz1sDlIvWp
         y9x0em8m+NikwUFYljbDB8z7civeGyFnyFV9L86qdAMwXfX8ts6i9R+4wQ+U60hj1q
         Z8ESEqTjJDLveWP8XIcNoISTh1f5QQ8XZViQu+aY=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d39417c2-30ab-18ae-2f04-6d2c86007df6@yandex.ru>
Date:   Wed, 28 Jun 2023 15:25:05 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] support busybox modprobe
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
References: <20230627182731.3428042-1-stsp2@yandex.ru>
 <20230628085241.olv63wqya2tcej6o@zlang-mailbox>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <20230628085241.olv63wqya2tcej6o@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


28.06.2023 13:52, Zorro Lang пишет:
> On Tue, Jun 27, 2023 at 11:27:31PM +0500, Stas Sergeev wrote:
>> This modprobe writes help to stderr.
>> We need to redirect it to stdout, or it will end up in a test results.
> Which modprobe version writes help to stderr, can you show more details?
As I said already, its a busybox modprobe.
BusyBox v1.36.0.

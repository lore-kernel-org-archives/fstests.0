Return-Path: <SRS0=nbej=YQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C411ACA9EB9
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Oct 2019 22:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FAA2173B
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Oct 2019 22:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyoGNNqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390461AbfJWWR7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:17:59 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41487 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389112AbfJWWR7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Oct 2019 18:17:59 -0400
Received: by mail-il1-f194.google.com with SMTP id z10so20452232ilo.8
        for <fstests@vger.kernel.org>; Wed, 23 Oct 2019 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVTJ6jc28E5GDiHSrhwkrCh6wMfC6ICAWi5hmAsluF4=;
        b=EyoGNNqQF58QYsWHGfTdgTURlfFSzyf0uj1OKMKSJN8VXfsZpC9KvmcsCyh+z/LQJi
         XYf+PoDxgCjfKXTzkGlhDAqD8EySMUhgImzSTK4CbZQVd+4hlhenLRqna3Uy1XIyAMKX
         m1K/oiiIS72Mqz0U4ro8dNcuIsayhOvtJXJSeLa1kej5JCjqGaxByDa4Cq/bzAgpae9P
         rHMnJODge36qispC642RyukcdgGSPVmx/jjpbN7/8L10xLSkWE3BvQqGYk/XI0ldVENl
         85XnQ1w1wZ1UGPtAdoGRAF+Dhp2QgFsqjPQzstl3hmumBnzL8oieWraPNOBBC0VWnev1
         tVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVTJ6jc28E5GDiHSrhwkrCh6wMfC6ICAWi5hmAsluF4=;
        b=fxjkXIKJpID5EHfPkNt/Tl/9ehCuhGzXjrvf8AgwyoCbWM4AHEpeSHXJQurFZAh8Ty
         quoTZpWSM10YcEJzcPbZTeW5oLfxX/H4akPr2GIPRiBmV0EzxeI5XNP+2FVS85JN0O4H
         h59Y/pCXNbDYPTPgg07hI4oFXtP2s8aPUFNfug/sf9cUZWLy/yqnNM+zhdQLVro5/Utd
         sjAlCshCKcAcq7zGelhHo5gbnTIMaUz/eLKTHIi+rkF/JEjHpORSjDzUXFrGQJAw++vb
         HAHxj61mRoXdEgGQG+N5ZHgZBjcuWfJbCiWPdDUmN3ZFrr7v02/OcnKJ3f+KCXOUt2+y
         VJFQ==
X-Gm-Message-State: APjAAAVCPJPKt+3mArHGdh1HcpgqQLXI0y+lhObTb0EeR6h8w//oTNFq
        YQVP4pEz1JExA/vBjWYsm7O75/y8cFfis/6TRE0=
X-Google-Smtp-Source: APXvYqwCdoPzRNxxJK0tutk0bwtPnmL2NNY1xmuyf/zTbxnCVGGiBRz5laLMa0O2oCgeTrcZpOJq3vOtk0RnWgNyyC8=
X-Received: by 2002:a92:8746:: with SMTP id d6mr41338436ilm.265.1571869078221;
 Wed, 23 Oct 2019 15:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190719041231.26500-1-deepa.kernel@gmail.com> <20191005183517.GE2622@desktop>
In-Reply-To: <20191005183517.GE2622@desktop>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 23 Oct 2019 15:17:46 -0700
Message-ID: <CABeXuvr_gVO4NXOgptqQF_RijrnmBiTwG6yaWwAoB+pr--c5MQ@mail.gmail.com>
Subject: Re: [PATCH] generic/402: fix for updated behavior of timestamp limits
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Oct 5, 2019 at 11:35 AM Eryu Guan <guaneryu@gmail.com> wrote:
> We already print error message on test failure, which will break the
> golden image, so there's no need to return 0 or 1. All similar checks
> and returns are not needed in other functions.

I removed the status checks and associated returns.

The patch is posted at
https://lore.kernel.org/fstests/20191023220401.12335-1-deepa.kernel@gmail.com/

-Deepa

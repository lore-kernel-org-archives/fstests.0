Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3033AC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Nov 2021 11:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1D161073
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Nov 2021 11:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhKNLhS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Nov 2021 06:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbhKNLhR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Nov 2021 06:37:17 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B94BC061746
        for <fstests@vger.kernel.org>; Sun, 14 Nov 2021 03:34:23 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id i194so4359669yba.6
        for <fstests@vger.kernel.org>; Sun, 14 Nov 2021 03:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GxHh7Xf9qDW0bNwOyf54n9RvWNxiu2gzljLfng7W7Hs=;
        b=Hkx6kd5Y6wfnns03GA1SRCPIUTynBDX6QIPciZkEAA0GruDt8lQBtj5GBgFQfJZ7OT
         P9DoxVMNlTvsOLY7u/xFKNpDLu+Ly8zLYLu0VFg5pR0PEbO6ONueZ2TOCUDSj7Zvxh7e
         mGQCua1J+C3CNB+YPiG5OP1pjWmqAplI+8pjLmV9JDdDVtPCwU8KRIUSJj5SY2RLC7zf
         o/195lJOXDLavNDJC9wp4p1oWu1j99gHdkydkGGb8AbXaP41KY+B8eCNcB+WCbLd9mTt
         T1d5oB0k1bLZKaUVyzVAPCOwyMcaFd224SOKhP6ZGgDI16fKNDpbctGg85K59AAGlVj+
         JrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GxHh7Xf9qDW0bNwOyf54n9RvWNxiu2gzljLfng7W7Hs=;
        b=ZKQtVph9zmiq5RLlx+kYuOuYrJawPPix84yjzcnCrVSPKfFaDJ8TmRjwC42maldwvc
         9WDt3yuj6ysFNQ4BpIhZbZAfGQhw+1ha5Z67p3NYN6/A6LbxkqQuZzX3mdImcHe6pfFL
         MAis/b7nngVeQdLaW+b+fir64O/LXjG/OE+SYn2ffvm3WQBM0KcL1jRKBekgfQ+fIbA3
         Dwn/jAi82TsbxLJ+M3xvs/HBvR2LBupdVdsdQ4iGJJ+ulnbSz1oNdmTDnLnog2qy+ajV
         So+RsxHQWPE1qeMNi3dYHECaHqFPrwTfY8Q7YTHOF3NKMf/yd6Sy+sPbtyckN2FGAIKG
         rplg==
X-Gm-Message-State: AOAM532TGW3P9lw7Fl+5GdC7WpsnD+QCU0BBY2NrNM5SLZjvwC9whI74
        m5jmLGGWHb+ISpwl+ACABNYLxIGk12+dmguRyjTHlc411xo=
X-Google-Smtp-Source: ABdhPJyGZHs5rgx1gOehdPMuOR4IFQ14/WnWSSpdpkenE5zMj+yjrina8CPwTsKDpqajAclWDHY55Hq7TrNbk+6nEd4=
X-Received: by 2002:a05:6902:1543:: with SMTP id r3mr34813421ybu.166.1636889662317;
 Sun, 14 Nov 2021 03:34:22 -0800 (PST)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <ceo.teo.en.ming@gmail.com>
Date:   Sun, 14 Nov 2021 19:34:19 +0800
Message-ID: <CAMEJMGGyAQ=qOUdpZkHs1ZyaaVtbZ19Qs1w-jeMvMQ=YCaR-iw@mail.gmail.com>
Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch
 is Running an Operating System with Linux Kernel 4.4.120!
To:     fstests@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A
Switch is Running an Operating System with Linux Kernel 4.4.120!

Good day from Singapore,

I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch is
Running an Operating System with Linux Kernel 4.4.120!

INTRODUCTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

My name is Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 14
Nov 2021. I live in Singapore. Presently I am an IT Consultant with a
Systems Integrator (SI)/computer firm in Singapore. I am also a Linux
and open source software and information technology enthusiast.

You can read my autobiography on my redundant blogs. The title of my
autobiography is:

=E2=80=9CAutobiography of Singaporean Targeted Individual Mr. Turritopsis
Dohrnii Teo En Ming (Very First Draft, Lots More to Add in Future)=E2=80=9D

Links to my redundant blogs (Blogger and WordPress) can be found in my
email signature below. These are my main blogs.

I have three other redundant blogs, namely:

https://teo-en-ming.tumblr.com/

https://teo-en-ming.medium.com/

https://teo-en-ming.livejournal.com/

Future/subsequent versions of my autobiography will be published on my
redundant blogs.

My Blog Books (in PDF format) are also available for download on my
redundant blogs.

Over the years, I have published many guides, howtos, tutorials, and
information technology articles on my redundant blogs. I hope that
they are of use to information technology professionals.

Thank you very much.





-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

***************************************************************************=
*****************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

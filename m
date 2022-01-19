Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D37C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Jan 2022 13:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350023AbiASN5z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Jan 2022 08:57:55 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36680 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiASN5z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Jan 2022 08:57:55 -0500
Received: by mail-ed1-f52.google.com with SMTP id 30so12168913edv.3
        for <fstests@vger.kernel.org>; Wed, 19 Jan 2022 05:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEDmN4u2k2CYG+TWyQJ1qN+o8CgdXATBRPnwzBN/WgM=;
        b=fgUAA7ltfWUtEfQjhkHKzqHG7mSouXry0agwbC0+n34+dnExKuobgSHm8EHk6txvbz
         E8yX7imspCefyhYmhWWBlWlJUd4hBaFkkifaEXHjWMSdYWZzbvXHqbTyBzPSBTbJzyJG
         hDOppygyKVyMv2bBRrFyp+EpkkGJQ1vD9BKhEN9I7QbBZU7zvjqDwJNq7Ot3H+F8tQXz
         GrofIa19eBcjYNg4KPwKfAZ2c1Iklac1g3top51uDWpRTicg8t8cEnXtpTAXJfpxsrTk
         ZhXGjI7kVE2d0L931BgYDOusE0F5uWqd78V0FHKBqt2r+zYIcvWXk/t1Rh8AHU+EpERu
         ozAw==
X-Gm-Message-State: AOAM530CeElQ7oH0I4Oc6t4jPnbCEGhq3whHxSZLPO8X4S7lKOoTMYch
        R4INXFpo/86NDU464XAPunIAf6bZpvP2h58XRV5osg==
X-Google-Smtp-Source: ABdhPJyoNW4HWJlYUVZlN+d3NYtjef/N9aYCsbZaR26yJDheUUW379fr8cUWyjeFJGd/Qp1c/GPvvAfg8mtPFnIyva4=
X-Received: by 2002:a7b:cd19:: with SMTP id f25mr3712133wmj.72.1642600673952;
 Wed, 19 Jan 2022 05:57:53 -0800 (PST)
MIME-Version: 1.0
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com> <YeY6Uh8I7RlsCicw@mit.edu>
 <61E64FED.2010906@fujitsu.com> <87r195i1lq.fsf@oldenburg.str.redhat.com>
 <61E7AC82.8080801@fujitsu.com> <61E7BBD6.3010706@fujitsu.com>
In-Reply-To: <61E7BBD6.3010706@fujitsu.com>
From:   =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Date:   Wed, 19 Jan 2022 10:57:42 -0300
Message-ID: <CAPBLoAf9MDA4u_PerRVd25gx0hg4tEH+AUkPyo48Vj5qAaV+0w@mail.gmail.com>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull call
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "morgan@kernel.org" <morgan@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 19, 2022 at 4:20 AM xuyang2018.jy--- via Libc-alpha
<libc-alpha@sourceware.org> wrote:
>
> Hi Andrew
>
> errno doesn't be initialized to 0 when c program link with lcap since
> libcap-2.30 (commit f1f62a748d7c Refactor the way we do the psx linkage
> in libcap introduced this bug.)
>
> The c example code as below:
> -------------------------------------------
> #include <stdio.h>
> #include <errno.h>
>
> int main(int argc, char **argv)
> {
>         printf("errno %d\n", errno);
>         return 0;
> }
> ---------------------------------------
>
> #gcc test.c -lcap -o test
> #./test
> errno 1
>

Yes, that reproduces the problem, quite well. (link with
-Wl,--no-as-needed if it does not trigger the bug for you)

This is not a glibc problem though, looks like lcap is clobbering
errno. I'd bet good CLP on the code called in
__attribute__((constructor (300))) static void _initialize_libcap(void) .
I strongly suggest not to use constructors on shared libraries unless
all the components using the library are in your control and you are
sure constructors will not ruin some other application's day.

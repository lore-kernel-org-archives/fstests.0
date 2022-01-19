Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9706C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Jan 2022 14:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355290AbiASOu6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Jan 2022 09:50:58 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:36521 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiASOuy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Jan 2022 09:50:54 -0500
Received: by mail-qt1-f173.google.com with SMTP id c19so2519656qtx.3
        for <fstests@vger.kernel.org>; Wed, 19 Jan 2022 06:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9vfM8g72TwF6zow4nuUq8XN0r4ZCEdEQNwxF90h1tss=;
        b=Rvp3yC0K2T6uAMNJ5U+S60BvvmuFVkWsLTYv1YRIOpQCKy/3gEsSszQd+x4cnV4da4
         pJ1/X2uvrBqIRpqHXB4hjoYgozkqxC6ZQCFaRB/LtYyqIt6FyAo+HOtPt8OC0u3npIZ8
         juj2ilTtVEtDh9wX7OA7al7NNsYvQMTulfXyuC7T4hompOivDbUe1Y+N37hvi046Tv1S
         ahzhSftSF8r1yQnOg2zObSalK4yMj14FEXPc8etK/RqujOb/GqRfmuIfANkA619Yem8+
         OkDUILIQuiJX0hd6bTCKW3L69thlGXZ8vTy7htf1cXeEVTgTO4lNQXmWkSqZzC+ePyqp
         PTDw==
X-Gm-Message-State: AOAM533NylNNFyXeRWBzmr/GROJ8Y1XUVv7m3P5hiBsFOQHn5gbIP4PB
        H7JsbZpLyrNZPeNuH6wwOTIgmHXq4HQB1XT73Dq5eg==
X-Google-Smtp-Source: ABdhPJwCRdez45wQ4KQhMBTm0zqzO00DgPjF+rJurE3tHzbVVhb9yvyANqJFbIyFXt7Uj50N8s1gON4unzvQoTMh8LE=
X-Received: by 2002:a05:622a:120b:: with SMTP id y11mr1309244qtx.307.1642603852875;
 Wed, 19 Jan 2022 06:50:52 -0800 (PST)
MIME-Version: 1.0
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com> <YeY6Uh8I7RlsCicw@mit.edu>
 <61E64FED.2010906@fujitsu.com> <87r195i1lq.fsf@oldenburg.str.redhat.com>
 <61E7AC82.8080801@fujitsu.com> <61E7BBD6.3010706@fujitsu.com>
 <CAPBLoAf9MDA4u_PerRVd25gx0hg4tEH+AUkPyo48Vj5qAaV+0w@mail.gmail.com> <CAPBLoAc3H_+aZbZTakODK9Azz7qvpc_SnCh4U5Jxfx0TWKcDsg@mail.gmail.com>
In-Reply-To: <CAPBLoAc3H_+aZbZTakODK9Azz7qvpc_SnCh4U5Jxfx0TWKcDsg@mail.gmail.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Wed, 19 Jan 2022 06:50:41 -0800
Message-ID: <CALQRfL4wBQc_tT3b8daivFh7nxad0kfhG7MM2Nx=_nHJ-myphQ@mail.gmail.com>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull call
To:     =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Cc:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks for finding this.

Fixed in:

https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=f25a1b7e69f7b33e6afb58b3e38f3450b7d2d9a0

Cheers

Andrew

On Wed, Jan 19, 2022 at 6:08 AM Cristian Rodríguez
<crrodriguez@opensuse.org> wrote:
>
> On Wed, Jan 19, 2022 at 10:57 AM Cristian Rodríguez
> <crrodriguez@opensuse.org> wrote:
>
> > This is not a glibc problem though, looks like lcap is clobbering
> > errno. I'd bet good CLP on the code called in
> > __attribute__((constructor (300))) static void _initialize_libcap(void) .
> > I strongly suggest not to use constructors on shared libraries unless
> > all the components using the library are in your control and you are
> > sure constructors will not ruin some other application's day.
>
> __attribute__((constructor (300))) static void _initialize_libcap(void)
> {
>     if (_cap_max_bits) {
>         return;
>     }
>     cap_set_syscall(NULL, NULL);  --> nope
>     _binary_search(_cap_max_bits, cap_get_bound, 0, __CAP_MAXBITS,
> __CAP_BITS); --> 🤔
>     cap_proc_root("/proc");
> }
>
> do, what cap_get_bound does ?
>
> int cap_get_bound(cap_value_t cap)
> {
>     int result;
>
>     result = prctl(PR_CAPBSET_READ, pr_arg(cap), pr_arg(0));
>     if (result < 0) {
>         errno = -result; --> If all my bets paid , I would be rich..
> here is your 1
>         return -1;
>     }
>     return result;
> }

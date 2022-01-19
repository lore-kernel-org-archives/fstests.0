Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A2BC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Jan 2022 14:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350170AbiASOIM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Jan 2022 09:08:12 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37820 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiASOIM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Jan 2022 09:08:12 -0500
Received: by mail-ed1-f50.google.com with SMTP id c24so9973884edy.4
        for <fstests@vger.kernel.org>; Wed, 19 Jan 2022 06:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S4g7tUIJQHMvL2+DDAT9a1BrA7g2DAQS0kkthszbL7E=;
        b=uBLOHjaC40IVFKHwQxet2umefx+C0GWHRRVbriMJphzOwsvd8AjivYI2PPgGraT7X0
         4GTtNoE3hde5zRdp6pAHtSY/qZcr4ZtM3QLS90wZTW0fzr5Rdyk2tD4NjTLqVTgAVoLw
         uNpOLI7ztnFV6JRfD9YU3PhMJD3OYXwgnqEHBElgb8VmjLz2Y976xOMFBhuRBT8+MZOl
         CklB4ldREac6pauFHLehMlwgX7+sdR2Sp41fGd3OR2EG6eU1RMsbMFPl7yQFurjJSELf
         YmN+4GHGNHr9LzVTxPeYo8xX6/F95mXl0qhCWePuwymvujSrjqvT7YLpIj93KLLAdyv5
         ajCw==
X-Gm-Message-State: AOAM530BfdGnk9DbFfK45c8V+fRw7McDj0x6L5XsyE83d9/D9ZNN9Su9
        PqH/9SXhAo9a6xqgbXOFQLwxIwGX3RUJugA3C3cAHKkTghNK9A==
X-Google-Smtp-Source: ABdhPJzw5mzgjJe6h9f4THyQFNjgwp61536E1HfLvlz3ljwRgq/o9ypjEwsTCdPNY/zOVsM48Q5FDRCL0VrWiJQ2r4g=
X-Received: by 2002:a05:600c:190a:: with SMTP id j10mr3688012wmq.55.1642601291088;
 Wed, 19 Jan 2022 06:08:11 -0800 (PST)
MIME-Version: 1.0
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com> <YeY6Uh8I7RlsCicw@mit.edu>
 <61E64FED.2010906@fujitsu.com> <87r195i1lq.fsf@oldenburg.str.redhat.com>
 <61E7AC82.8080801@fujitsu.com> <61E7BBD6.3010706@fujitsu.com> <CAPBLoAf9MDA4u_PerRVd25gx0hg4tEH+AUkPyo48Vj5qAaV+0w@mail.gmail.com>
In-Reply-To: <CAPBLoAf9MDA4u_PerRVd25gx0hg4tEH+AUkPyo48Vj5qAaV+0w@mail.gmail.com>
From:   =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Date:   Wed, 19 Jan 2022 11:07:59 -0300
Message-ID: <CAPBLoAc3H_+aZbZTakODK9Azz7qvpc_SnCh4U5Jxfx0TWKcDsg@mail.gmail.com>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull call
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "morgan@kernel.org" <morgan@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 19, 2022 at 10:57 AM Cristian Rodríguez
<crrodriguez@opensuse.org> wrote:

> This is not a glibc problem though, looks like lcap is clobbering
> errno. I'd bet good CLP on the code called in
> __attribute__((constructor (300))) static void _initialize_libcap(void) .
> I strongly suggest not to use constructors on shared libraries unless
> all the components using the library are in your control and you are
> sure constructors will not ruin some other application's day.

__attribute__((constructor (300))) static void _initialize_libcap(void)
{
    if (_cap_max_bits) {
        return;
    }
    cap_set_syscall(NULL, NULL);  --> nope
    _binary_search(_cap_max_bits, cap_get_bound, 0, __CAP_MAXBITS,
__CAP_BITS); --> 🤔
    cap_proc_root("/proc");
}

do, what cap_get_bound does ?

int cap_get_bound(cap_value_t cap)
{
    int result;

    result = prctl(PR_CAPBSET_READ, pr_arg(cap), pr_arg(0));
    if (result < 0) {
        errno = -result; --> If all my bets paid , I would be rich..
here is your 1
        return -1;
    }
    return result;
}

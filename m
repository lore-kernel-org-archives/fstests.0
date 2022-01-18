Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93611C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 14:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiARO3l (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 09:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiARO3h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 09:29:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1538DC061574
        for <fstests@vger.kernel.org>; Tue, 18 Jan 2022 06:29:37 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so758657pja.2
        for <fstests@vger.kernel.org>; Tue, 18 Jan 2022 06:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A6/8lqxpaoNZBrhADMY//ieFuJ9CiGfe5sWorX/7Qac=;
        b=ins7Htxsns7dfOorKc8uSdSVWnTLr+qevKOThNGhM8JN0N3sHQNWbv5Z3SmFQHl1wK
         fUGwyO46yZVn6jCs4ZhXwrqaXXpqgshTa0EXRlBLg8VLI2vQs/D9WnaJEMfHyMS/1s+s
         RbsBA7AWMuMkoZBkbVc/Dhl6YTyNwfTt7DE3HAwgcHXTuC8cxLsmDH5yYnHJlFx8lWKy
         oyubqT9E8lxIjIESCoF7TcNEVXpcYYWW4zTYeimkSS3sPNrQGuGZzDy3SR69Cr3GZwMu
         kZVU3OAMC+6S1D8SI139EmI9xsEoE3P9eTwMFPGm4RWIBnBTJtyuytq15Z3Qeioi+kly
         QuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A6/8lqxpaoNZBrhADMY//ieFuJ9CiGfe5sWorX/7Qac=;
        b=itX/6//Eus38tDjOnIraN090aX1Qi+zhEBLbJB2oGH3o0JeFWQsNc31oGAbltgIgwW
         wIJjRQ+BciTqKFiDRO4+1oF0Kh3d6H5WZ4dztCkpsonvhedWKjKHCthf2kjKEB1sGy7/
         G5WqzENVG1h0ZFVqkLCW3gFv4P/UqMD2lmVZvZ8PwHoLv0SAJUHex7sdvC8a8WMQw5Bc
         VNXUd4nu2iLukA3BcNxebnPAzvdxBee23YbfZhFL+2hv2AnjLAJaM88Dl+p/iHyFBXs2
         xQXl1g/OtVQ2pWVyV74KOpUFtyHb04UPCroOVgDSmZWAPptzMngRu3/wZEGelOtUKUvY
         v9Hg==
X-Gm-Message-State: AOAM530bqvSafTctMuTJjaQl5qb4JGb6NWv9cole2zDfQrkGCt3sajWR
        P+NKiN0x+K4bYWLLiQdoC+yQhLQ/0X7QhzH8ZYc=
X-Google-Smtp-Source: ABdhPJz9aCASzcudsaFOj+l3h2mIbbU6c/6cJlP3IuhbUbxS2wwJE5G1LemEWBDNHw/tcgEQV7t6qI97nRBYRJF+5Us=
X-Received: by 2002:a17:903:1c4:b0:14a:555c:adc0 with SMTP id
 e4-20020a17090301c400b0014a555cadc0mr27497578plh.101.1642516176542; Tue, 18
 Jan 2022 06:29:36 -0800 (PST)
MIME-Version: 1.0
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com> <YeY6Uh8I7RlsCicw@mit.edu>
 <61E64FED.2010906@fujitsu.com> <87fspl6s44.fsf@igel.home>
In-Reply-To: <87fspl6s44.fsf@igel.home>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 18 Jan 2022 06:29:00 -0800
Message-ID: <CAMe9rOqtG6wHG=u2RbcgT5WmqyO7aXTK23d-gWFUVzeibgdiCA@mail.gmail.com>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull call
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     xuyang2018.jy@fujitsu.com,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 18, 2022 at 6:22 AM Andreas Schwab <schwab@linux-m68k.org> wrot=
e:
>
> On Jan 18 2022, xuyang2018.jy@fujitsu.com wrote:
>
> > Now, I use glibc-2.34 and run the following program[1] but the errno is
> > not 0 in the beginning. So is this a known bug on glibc-2.34(Theodore
> > doesn't meet this problem on glicb-2.31)?
> >
> > [1]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/ext4=
_resize.c
>
> Note that there is a call to open preceding the strtoull call, so no
> guarantees can be made about the value of errno before the latter.
>

strtoull man page:

RETURN VALUE
       The strtoul() function returns either the result of the conversion  =
or,
       if  there  was  a leading minus sign, the negation of the result of =
the
       conversion represented as an unsigned value, unless the original  (n=
on=E2=80=90
       negated)  value  would  overflow; in the latter case, strtoul() retu=
rns
       ULONG_MAX and sets errno to ERANGE.  Precisely the same holds for  s=
tr=E2=80=90
       toull() (with ULLONG_MAX instead of ULONG_MAX).

new_size =3D strtoull(argv[2], &tmp, 10);
if ((errno) || (*tmp !=3D '\0')) {
^^^^^^^^^^^^ Shouldn't errno be checked only after the prior function
return value is checked first?

fprintf(stderr, "%s: invalid new size\n", argv[0]);
return 1;
}

--=20
H.J.

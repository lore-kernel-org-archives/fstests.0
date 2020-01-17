Return-Path: <SRS0=Jsw6=3G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB605C33C9E
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 18:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8368A2082F
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 18:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ve5fCSD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgAQSXO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:23:14 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41792 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQSXN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jan 2020 13:23:13 -0500
Received: by mail-il1-f196.google.com with SMTP id f10so22006154ils.8
        for <fstests@vger.kernel.org>; Fri, 17 Jan 2020 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8ksIfeUK4q3qG+FIUWbnRaQDnE3Ut9WjIZ8XxGrPj8=;
        b=ve5fCSD2CgJXdspBJ96pBaWoFL7w3aUzrJJUNYwAhry3h/npHJ84BqTX4NHiBPAnBg
         asxOvAEGt3H2D3/XCOnVty5VJY3ywwy6U006lpazMRHAUIXhUdVK8DRydknsEtFbriqV
         Z8gbkOG9sqcYJfCUrLpvpyXvVDEBWsxedlF1wxfYNIAKX8KmJ/Vamac+mAICsBaXY3DK
         tOVICXawi70yNlcS8GlnE7LL7xHo+6/XWMBmQbh0RvPA3TbPADPdcYQjdigUnFORciT9
         0BU/jngz9u1Pre4zhI/a7DCV2fp5HA5Lg9XhmKqa3vXVhlfSr+JSZk/5YDkspUE/bkh8
         YAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8ksIfeUK4q3qG+FIUWbnRaQDnE3Ut9WjIZ8XxGrPj8=;
        b=kO2duwHTndNOv/Mfz0+aOHfIHPCYxGPMv6t2EedpXQQOFTtIBkwiXCS2Dd7ehPqkRU
         YLzTGb82QlJonXFt/ER7scDd5SVno1TSIS6DoFV8jybdoO5DcL8xDq/W0LZAPQE01jWc
         XfuAn0o5Rzqholt7pC5nGq1oFaCFDe3h0ykbDRAlMLf1FhuNxmcJtkw7nmK/N1UpaHc6
         HYuRRpp6SMxxCIQO+Fy0bOk6wgQS7srWmWsgqBQh72MnoKtlysFN59TbE0J6hFUbR1D0
         EliUEYYJFaVlNG9NzE0lCYU/PZNQIVsb/XFGjQmoE3aMe9YKVJrAuIWrVtj2Waf1Xg1e
         L48w==
X-Gm-Message-State: APjAAAX+yvkiMhK+krK4EcY2G1quTWgWM0Io3+WDXuUw1WJZ9OzdP/I3
        5QhingbG4NUfRCA28hQYjw2p6/JNvXrBhyJ67hQ=
X-Google-Smtp-Source: APXvYqxBTFXcZuzmCuW8EXqggUejrvQivtSgA45HeQlDhxkTr8+5rR91tJqoFYZUw70KNv3PGidSATYtABeUUErpVbU=
X-Received: by 2002:a92:48c2:: with SMTP id j63mr3914877ilg.153.1579285392941;
 Fri, 17 Jan 2020 10:23:12 -0800 (PST)
MIME-Version: 1.0
References: <CABeXuvr74C0DS-K4_us4CdPPFxp=7RHmCHAZQQmJrh=PZfux-w@mail.gmail.com>
 <20191228221317.16654-1-deepa.kernel@gmail.com> <CAOQ4uxifpjjirTyUsCm03TFx8LOvkt0xX+RNyFZU5sHNU+bfqA@mail.gmail.com>
 <20200108080936.GG893866@desktop> <CAOQ4uxhOGZfLch1HDFACD9fLczpLHxVMoY50ZyJDOyAJBp-WyQ@mail.gmail.com>
 <20200108095021.GH893866@desktop> <CAOQ4uxg7cu5eYskPAEhGrB6MWrt9rzdg1+EadGBOBSmw7iN6hA@mail.gmail.com>
In-Reply-To: <CAOQ4uxg7cu5eYskPAEhGrB6MWrt9rzdg1+EadGBOBSmw7iN6hA@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 17 Jan 2020 10:23:01 -0800
Message-ID: <CABeXuvrexoO9y894EXU9vc8=BLvLMB8EgOi2OdxT1hp5xHFPvQ@mail.gmail.com>
Subject: Re: [PATCH v2] generic/402: Make timestamp range check conditional
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 17, 2020 at 1:09 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > I understand why you dislike the ext2+loop test, but please hear me out.
> > >
> > > From all the fs types that are supported by the test, only btrfs and ext4 with
> > > large inode size are y2038 ready.
> > > For the rest of the cases, we actually have a way to detect kernel support
> > > from the dmesg warning, without the need for hacky ext2 loop mount.
> > >
> > > So how about just:
> > > 1. moving  _scratch_mount before _require_timestamp_range
> > > 2. in _require_timestamp_range (untested):
> > >         if [ $tsmax -lt $((1<<32)) ] && ! _check_dmesg_for "supports
> >
> > Yeah, this looks fine. I thought about searching for dmesg warning after
> > _scratch_mount as well, but that would _notrun if the fs is 2038-safe.
> > This $tsmax check fixes my concern. Thanks!
> >
>
> Deepa,
>
> Do you intend to post the simplified version or would you like me
> to re-spin your patch?

I intend to do this. Sorry, was distracted by other things. FWIW, just
(1<<32) is not enough. The kernel prints this warning based on
(current time + max uptime) <= tsmax. Will post this.

-Deepa

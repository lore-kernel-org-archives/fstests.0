Return-Path: <SRS0=nV//=CB=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A1BC433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Aug 2020 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC7B206C0
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Aug 2020 13:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBvKjmga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgHWNXF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Aug 2020 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgHWNXE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Aug 2020 09:23:04 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E70C061573
        for <fstests@vger.kernel.org>; Sun, 23 Aug 2020 06:23:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id u126so6011773iod.12
        for <fstests@vger.kernel.org>; Sun, 23 Aug 2020 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEna4mveM6P8b6NGdoXsKcRxob0kSvdzF3gdm9iGb5Y=;
        b=PBvKjmgaYfHZMDN7xZB8Z3tHElSvkyYcunW3s4PTRRssQXhwuhmLcKjhvN5Z5HgUKl
         WaMnGN/T0MRNdJvMN15pwBS99Whnm4da/EkOsJ3a7z7hbs16ScwJELAiwRhHP1wq88Hc
         Waw704pF6lSgIWqQEufvufi+hncXLtjkjw7ZUhU1tk9FhwBMoDh67wKByYU/RvoirmvI
         44OBZTbW4+CoVposLWj+AFcwSKLvU0jVjn+2G/o4WKOZyGMgBpJz5UcaLYNH0rV4cTsH
         ZUGF5pUqJIYMdNtVSRBUUSRJ2GWUNtfM+JQc9veFvZidf8SFtRwhNj4cvzFuot0ADzjl
         K27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEna4mveM6P8b6NGdoXsKcRxob0kSvdzF3gdm9iGb5Y=;
        b=ek9w1uMaKrjbZD0ervynwGO9z+RKgRt+90i6ecXEM2QfzYwiPCzXTj3HdBn/9y4vmU
         IsuPxF4Ax8ZSUZcRi9duOWBm/gyiMP52g2o6bcuTIExvJFmlthKxLQsGZCj0VENkSwTx
         KIqEvLwyn7YB7qym/EiWBql3YOG90V3YuUwmcONl0rY8fzpJJPAHkwv017lm+4umYCZu
         RrFNIVH0xdSlyJsUpRTorhBiGs0xp4MIS5sVTeXhWJiySABccWJtHQ3nTunHs8x96t4q
         c3I0PjZIdncVjdsjhOAvS6843lWdv7aCH8yuVJstIEA+r4m9PT7hpNbucrztWu1Twkm4
         5/HQ==
X-Gm-Message-State: AOAM530anyvShwZ529rtNezPdQf26ekN1+LRZ46gkssaa2DH3dVYCuQF
        ytcD0CKG13kEDmZ2yrTkChvGtDXJyLnVITQp/xZl2ntbde4=
X-Google-Smtp-Source: ABdhPJxHNxTZa6lsfhPZkJSG5rwn3ylqDbMrznAEvDnI/aoPhXfQ/CgTUYVdV3PZaIPMnXVZisxTIju6LdGtbo5QEnM=
X-Received: by 2002:a02:a90f:: with SMTP id n15mr1254527jam.120.1598188979710;
 Sun, 23 Aug 2020 06:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200823113049.GZ17456@casper.infradead.org>
In-Reply-To: <20200823113049.GZ17456@casper.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 23 Aug 2020 16:22:48 +0300
Message-ID: <CAOQ4uxjzfSc1XfTbbBgcxTL-EfO67e_JUc8XPa9nUBb0iJ3bDg@mail.gmail.com>
Subject: Re: irreproducibility
To:     Matthew Wilcox <willy@infradead.org>
Cc:     fstests <fstests@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Aug 23, 2020 at 3:35 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> I have a particular dislike of random tests.  They make it harder to
> figure out when a bug has been fixed.  What's worse is when the test
> gives you enough information to make it reproducible, and we throw that
> away.
>
> I made the following change to find out the random seed that fsx was
> using for this test:
>
> +++ b/tests/generic/112
> @@ -57,7 +57,7 @@ _do_test()
>
>      # This cd and use of -P gets full debug on "$RESULT_DIR" (not TEST_DEV)
>      cd $out
> -    if ! $here/ltp/fsx $_param -P "$RESULT_DIR" $FSX_AVOID $seq.$_n &>/dev/null
> +    if ! $here/ltp/fsx $_param -P "$RESULT_DIR" $FSX_AVOID $seq.$_n &>"$RESULT_DIR"/fsx.stdouterr
>      then
>         echo "    fsx ($_param) returned $? - see $seq.$_n.full"
>         mv "$RESULT_DIR"/$seq.$_n.fsxlog $seqres.$_n.full
>
> I'm sure somebody can do something better than that which would actually
> result in it being automatically preserved-on-failure/deleted-on-success.
>

These files appear to be cleaned only on success:

rm -f $seq.*.fsx{good,log}

Not sure if intentionally...
You may as well use the same pattern.

But while we are on the subject of "random" tests, recently fsstress
gained a few
more random ops, one of them is RENAME_WHITEOUT, which can hang stable
kernels on xfs (at least on 5.7.10).

I admit that this has value - you pull latest xfstests, run the tests,
find a bug and
look for a patch to fix it. But this can also be pretty annoying if
all you are interested
is checking for regressions in stable kernels.

What we could do is mark all those tests that are a moving target with some
label such as "unstable", meaning that getting updates from upstream xfstest
may change the test, so that for regression testing, it would be easy to
exclude the "unstable" group.

Thanks,
Amir.

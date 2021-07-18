Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D34BC636C8
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Jul 2021 12:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5785C61181
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Jul 2021 12:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhGRM5G (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Jul 2021 08:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhGRM5G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Jul 2021 08:57:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F632C061762
        for <fstests@vger.kernel.org>; Sun, 18 Jul 2021 05:54:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c17so1571374wmb.5
        for <fstests@vger.kernel.org>; Sun, 18 Jul 2021 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XsO73sHAeGsufuMGStA7zzmflJaWpHERkfTgUIiM88o=;
        b=e1Qan7zXTa4WqWP/6/0BvaJQbDLceRGowQ115FkSLMUW9FPUw9H6OCyaazHsdojQaF
         ARjGFGyFx7EgB7tGSgeu9QNU2fPnB1M5FD8NedMSLrg8o0BDzh6hIq29rG8faK6GnUea
         8lQikeBWnuYdnv+fk0FHvL69fKJloYx5RBjFP44Wg6pFKHtp6sQQm7ebfNFi2yZMj5jY
         LdL+eXunzWmn/V5S7nXiTIwNtY32gJDQrAisIWaClrtoaPH+CD80Ut6iw9JjoCGu59DH
         noukVBSnhpLZiR1vP1OeiOq7JiUO3pBuvCalRCBRm/vQ9ClPVlJCcLzKpCSZMuWME6zE
         HKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XsO73sHAeGsufuMGStA7zzmflJaWpHERkfTgUIiM88o=;
        b=WkOLQeGymYTnsqLQTTnN3qSjh9zezml/Z3LmFua+ctt+nNSUqPWZjMq8Xfe75EouFc
         n8TVDM/ms0yIHfcPUhhTkACgQeTy19yJG8VDDJlVypuTmDgD+C+lLPbGP60hdkMxbjtY
         dda1xTIXlT33VTESpWqNBTyVxpyjtZgX5jX0u5xkYmyiEmBD3a4jYCNP3ggsITCoFrpa
         KO0XIIsWyk5vHEQTNg+ScKGbkN5TZeTJXWfDgVD/9mzmA76xwEGg7N4XwPMS2Hp1YIlc
         ohSRgaqumjAPW3XXvIX3wFo30tne7Bdjdbu9DDJujDryl5KSg0gWMYzvQGY9tO2ri5u6
         bdXA==
X-Gm-Message-State: AOAM530CqS44kM6heEuEYhAvLKNculUcDuuY1gC+vQLeXVe9WWuK21G9
        F4GBoU1aWYwdG27GV6TZJYI=
X-Google-Smtp-Source: ABdhPJwCIYotRGc2s3jFCxLuFsWcGn81r48Dv4kKcdG24H8vtHFo1ZgJkhO7NuhL5PJp/1kIteVNjg==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr21181719wmj.109.1626612846601;
        Sun, 18 Jul 2021 05:54:06 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id r16sm16923965wmg.11.2021.07.18.05.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 05:54:05 -0700 (PDT)
Date:   Sun, 18 Jul 2021 20:54:02 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Subject: Re: [PATCH 0/2] skip tests that don't work with an external log
Message-ID: <YPQkalv0mmLpsSnZ@desktop>
References: <20210705040307.3322709-1-tytso@mit.edu>
 <20210706174837.GA11571@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706174837.GA11571@locust>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 06, 2021 at 10:48:37AM -0700, Darrick J. Wong wrote:
> On Mon, Jul 05, 2021 at 12:03:05AM -0400, Theodore Ts'o wrote:
> > I recently tried running xfstests with an external log device, and
> > found a number of failures caused by the fact that we use dmflakey and
> > dmerror to take down a disk to simulate a power failure or a complete
> > hard disk failure.  But with an external log device, the tests don't
> > correctly simulate these scenarios, so skip them.
> 
> Counter-proposal: If I sent out my series to fix all that[1], would you
> review them?

Yeah, I was going to ask if xfs supports dmflakey tests with external
log dev. So Ted's proposal will break your work.

And if we want to disable dmflakey/dmerror tests with external log only
for ext4, I think we could do it in _require_dm_target() not in
_init_flakey(), something like:

_require_dm_target()
{
	local target=$1
	......

	case "$target" in
	flakey|error)
		if [ "$FSTYP" == "ext4" -o "$FSTYP" == "ext3" ] && _has_logdev; then
			_notrun "dmflakey/dmerror tests don't work with an external log device for $FSTYP"
		fi
		;;
	*)
		;;
	esac
	......
}

Then generic/475 doesn't need any update.

Thanks,
Eryu

> 
> --D
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=dmerror-on-rt-devices
> 
> > 
> > With these patches, testing with ext4 using an external log is passing
> > almost all of the auto group tests, with the exception of ext4/028
> > (which appears to be a genuine ext4 fsmap bug not handling external
> > log devices correctly).
> > 
> > Theodore Ts'o (2):
> >   dmflakey: don't run dmflakey tests with an external log device
> >   generic/475: skip test when using an external log device
> > 
> >  common/dmflakey   | 4 ++++
> >  tests/generic/475 | 4 ++++
> >  2 files changed, 8 insertions(+)
> > 
> > -- 
> > 2.31.0
> > 

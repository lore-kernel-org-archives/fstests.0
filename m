Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3392EC433FE
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Nov 2022 02:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKGCDn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Nov 2022 21:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKGCDl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Nov 2022 21:03:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEAFDF1F
        for <fstests@vger.kernel.org>; Sun,  6 Nov 2022 18:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667786564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=da7cErVH0B+Gt+S5f96ymbvCRbWB0qkx+ANWRWqJr3Y=;
        b=V975CVBaARRgIW7DgCa5Srp37jx68/Ra2gpm7dv3BEljQXok/EqPL8rEhLj8H9yb+puKVM
        lBV80hohjnYVhF6D9Z6+B1Pbo7Km90O+CBwx7C0HmnMi+Ft31rRKx0x/bCVsmmqMJfcXZM
        O6SB/cm34vfQd3hHZPdTM8GfDTLLZRU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-534-BXkBe7QNO7OJvvzPuIDOIA-1; Sun, 06 Nov 2022 21:02:43 -0500
X-MC-Unique: BXkBe7QNO7OJvvzPuIDOIA-1
Received: by mail-qk1-f200.google.com with SMTP id j13-20020a05620a410d00b006e08208eb31so9064564qko.3
        for <fstests@vger.kernel.org>; Sun, 06 Nov 2022 18:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da7cErVH0B+Gt+S5f96ymbvCRbWB0qkx+ANWRWqJr3Y=;
        b=onGog+NoDi4bq4RSSKj+XS/9fTBHUxCr6ImFhkP5Zor/2qXwPP11OoFaBu8coNoCdI
         v1HVdxM+xSgAdV6OySV5CKJsOh6Cb1WJJ61D2DIzgo2qalV7+JAhI8rEDBFF10xnOo5a
         IaW2GCanb08HFy3lPt+7DQrs0ekLMgVPeHeKwmx1EMLGGwm0ppFhxf4a9Wu1Hgazn6ah
         joolPqViyojMi2CFhPd4Vq4ohu6F21x2ATY2XFbCXlyLh3rS2J8AV+3c24CY0fhZtNYq
         4JTD44THobOeI8MpJoX9PL6kp0EX+U1wX+iZHUsWAoRBgyh2u+VLfdM9n+RmtUDsFSvk
         rXvQ==
X-Gm-Message-State: ACrzQf0wW621JwcPlNrVRYj2jVdo3OGzjwdGwjNvuZ64un2c/kXmLx54
        6wWi+r1FKsr0C+vUAtXMLl6dPr/N57hTvaxJyv5Me4QQE2mEKo4aVpgvOiMgH4nD4mAHpJGvG1x
        DnOKlITE4P3rylJi2sg==
X-Received: by 2002:a05:620a:2601:b0:6bc:70bb:c56b with SMTP id z1-20020a05620a260100b006bc70bbc56bmr34804021qko.416.1667786562033;
        Sun, 06 Nov 2022 18:02:42 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5Dg1kC0+bx/PKixoBJ+lMDfs4GgN8iujRx6EhwNqNOA0Do6xaSz29O6AqQhBDLjcFqHXA2RA==
X-Received: by 2002:a05:620a:2601:b0:6bc:70bb:c56b with SMTP id z1-20020a05620a260100b006bc70bbc56bmr34804008qko.416.1667786561753;
        Sun, 06 Nov 2022 18:02:41 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y6-20020a05620a0e0600b006eec09eed39sm5575620qkm.40.2022.11.06.18.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 18:02:41 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:02:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <20221107020236.gdlmb5hxsaxxislo@zlang-mailbox>
References: <20221105182918.24099-1-tytso@mit.edu>
 <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
 <Y2gqpYhf5n8Y43eZ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2gqpYhf5n8Y43eZ@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Nov 06, 2022 at 04:44:05PM -0500, Theodore Ts'o wrote:
> On Sun, Nov 06, 2022 at 08:10:31PM +0800, Zorro Lang wrote:
> > 
> > Thanks Ted, actually I'm going to merge this patch (with g/457 fix by myself)
> > this week.
> > 
> > But looks like you missed the change on g/457 (might forgot to commit). Anyway,
> > I think it's not worth wasting one more week for this small change, I'll help
> > to change g/457 when I merge this patch.
> 
> Argh, yeah, sorry, I forgot to do the "git add -u".  Anyway, here's
> the leftover change that was in my git working directory, if it saves
> you 5 seconds or so.  :-)

Hi Ted,

Thanks, I've pushed this patch last night :)

> 
> BTW, I noticed there were a number of fsx --replay-ops invocations
> where we could potentially add the $FSX_AVOID.  OTOH, it would
> probably make those tests completely pointless, so it might be easier
> just for the test runners to relay on a group-based exclusion in those
> cases.   What do you think?

I think it doesn't make sense to use $FSX_AVOID in `fsx --replay-ops` cases.
Due to generally the operations which a cases would like to replay are exact
steps to reproduce to a known bug. If we skip some operations (e.g. -F), it
doesn't make sense for this reproducer.

The recommended way for this kind of cases is making sure current fs/system
support the operations will be run by fsx, especially those features are not
common on different fs/system. Likes g/456, it does:

  write 0x137dd 0xdc69 0x0
  fallocate 0xb531 0xb5ad 0x21446
  collapse_range 0x1c000 0x4000 0x21446
  write 0x3e5ec 0x1a14 0x21446
  zero_range 0x20fac 0x6d9c 0x40000 keep_size
  mapwrite 0x216ad 0x274f 0x40000

So it uses below _require_* helpers to make sure these operations are supported,
before testing:

  _require_xfs_io_command "falloc"
  _require_xfs_io_command "falloc" "-k"
  _require_xfs_io_command "fzero"
  _require_xfs_io_command "fcollapse"

That's my point, hope I didn't misunderstand what you said :)

Thanks,
Zorro

> 
> 				- Ted
> 
> diff --git a/tests/generic/457 b/tests/generic/457
> index da75798f1..ca0f5e622 100755
> --- a/tests/generic/457
> +++ b/tests/generic/457
> @@ -83,7 +83,7 @@ FSX_OPTS="-N $NUM_OPS -d -k -P $SANITY_DIR -i $LOGWRITES_DMDEV"
>  for j in `seq 0 $((NUM_FILES-1))`; do
>  	# clone the clone from prev iteration which may have already mutated
>  	_cp_reflink $SCRATCH_MNT/testfile$((j-1)) $SCRATCH_MNT/testfile$j
> -	run_check $here/ltp/fsx $FSX_OPTS -S 0 -j $j $SCRATCH_MNT/testfile$j &
> +	run_check $here/ltp/fsx $FSX_OPTS $FSX_AVOID -S 0 -j $j $SCRATCH_MNT/testfile$j &
>  done
>  wait
>  
> 


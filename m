Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACEDC43334
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 15:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiGUPAN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiGUPAL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 11:00:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4724F76
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 08:00:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26LExm68021466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 10:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658415590; bh=ORCcn2+xztRzRaLzc1VO/tz0GeQpeODla1IidZX5/qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=L88MkP/YYNiynX7BkW3kSXZyrI4b730AN2E9F2W6hhIzyKGsHqkBme82+lzBlKx6M
         O8rFKirxOrfXgtW6wI4kdc+Z0qFD1sNtKVTjdMqpXPuYiDxHxLSDuERqdqpYPbBxfr
         C8NBSos4qXgletApi1g1Oud9smxisKGcZaJytcaCYMbHnXD/uGDJACMPLCk1Lul7hO
         Frur7mOZbTStP7weqhFyNL/lVUs9NDEL9zY80F0OFbq8wXULrXAwJKcHvePY3dwWJT
         /HdQGaVHb9rGxDkRPvU3pusRAtDrcsLZO3+WXNWwU+IyLjJSB2cYjUAzQ1lfnrh5yl
         p7JD8esdNgOUg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 377D115C3EBF; Thu, 21 Jul 2022 10:59:48 -0400 (EDT)
Date:   Thu, 21 Jul 2022 10:59:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, chandanrmail@gmail.com,
        Josef Bacik <josef@toxicpanda.com>,
        Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: Collaborating updates of kdevops xfstests repo
Message-ID: <Ytlp5ECl41Bvj0b3@mit.edu>
References: <YpjVcHuxhEQwPusN@bombadil.infradead.org>
 <CAOQ4uxi0eY3ybXbL6TEZv27HUoBaSTcthjC7aHRCTzACfyq52w@mail.gmail.com>
 <CAB=NE6XAL1+OXV0X5zBZCMWsqsy-xz9E6rkwPkGOHRXyG4sohg@mail.gmail.com>
 <CAOQ4uxjbJWt06bx_iE2mh=JemuM+fAAGU2WGYV7vOWQzvY4wMQ@mail.gmail.com>
 <CAOQ4uxjHp5iz4kP1qRbQtXSu3frVUhvxr23Gc0jzW9nY+_ep3A@mail.gmail.com>
 <YtlmsH6vohI2/ttV@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtlmsH6vohI2/ttV@bombadil.infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 21, 2022 at 07:46:08AM -0700, Luis Chamberlain wrote:
> If you look fstests has no release tags. Long term I think it would be
> wonderful if we strive for that...

Since May, Zorro has started providing release tags --- it's tagged
when he pushes a batch to for-next, and so far there hasn't been any
changes between when a batch of updates get promoted from for-next to
the master branch.

% git tag -l | grep ^v2022
v2022.05.01
v2022.05.08
v2022.05.15
v2022.05.22
v2022.05.29
v2022.06.05
v2022.06.12
v2022.06.26
v2022.07.03

So if you want stability, you can wait until after the tag has been
promoted to the master branch.  I've using the for-next branch for
xfstests-bld, since I'm also doing development work for xfstests, and
before I release an prebuilt image for kvm-xfstests or gce-xfstests,
I've done a full sanity check run on at least ext4, xfs, btrfs, and
f2fs.  And aside from a relatively rare hiccups, I've found for-next
to be plenty stable enough for me.

Of course, it's a bit easier for me, since I've explicitly *not* been
promising that a reliable set of baseline configs that can be used for
drive-by testers.  OTOH, last I checked, kdevops hasn't published new
baselines since 5.17, which IMHO is way too old for drive-by testers
who need to test patches meant for upstream submission anyway...

Cheers,

					 -Ted

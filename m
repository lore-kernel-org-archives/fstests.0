Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4A2C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 21:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiF2VUz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 17:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiF2VUy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 17:20:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E16B13F79
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 14:20:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AA1B614C6
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 21:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFFFC34114;
        Wed, 29 Jun 2022 21:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656537653;
        bh=QwRKivR80yhvoZNGMKedfEPROY3qDjOuxojmvOVEcRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CaTfrjmDb9SqSSTLQtTjZseJnkpbkkdAHhiX7ndEsDY4x32WiV31G01z9LWMD/lRt
         3ANymJBXofqDOUdHQI030PwBvilb07hhv/JF3oQi2f+bL1kpNimfTqAUiaFJ3u9IaT
         w79gmUSpBTXmxV0DmZUJNXWmvx8oAekMzpzKYPC6EdGqhvZfqpYmZYaoB8rJGKHsqm
         ZO1kYH/XW3wLUh0s6Wy4NNxD/BHJC73zMTejKAfsXuN0inBVQSC1JmFk9ZRlPBSFsA
         tAqmxVj1UeOv6P8FouAU7x2+skIh+G1UdqttEKgqj3qKQZJcmP6U7NTxo8Sp5QmQ1C
         IwzjcR+EiJESg==
Date:   Wed, 29 Jun 2022 21:20:51 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH -v3 7/7] ext4: create file systems with the encrypt
 feature as necessary
Message-ID: <YrzCM/Ti9WLzYS6N@gmail.com>
References: <20220629124540.175775-1-tytso@mit.edu>
 <20220629124540.175775-8-tytso@mit.edu>
 <20220629133052.3knyrselanytvrws@zlang-mailbox>
 <YryoPGksgK3UfKvO@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YryoPGksgK3UfKvO@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 29, 2022 at 03:30:04PM -0400, Theodore Ts'o wrote:
> On Wed, Jun 29, 2022 at 09:30:52PM +0800, Zorro Lang wrote:
> > 
> > As Eric gave some review points to V2, so double check with Eric, if it's good
> > to him?
> 
> Eric, any other issues than the ones which you had mentioned (and
> which I have addressed)?

Well, not all the comments I made on v2 were addressed; see
https://lore.kernel.org/fstests/YrvgMkrXh8iUItVv@sol.localdomain.
As I said, the overall approach is fine though.

- Eric

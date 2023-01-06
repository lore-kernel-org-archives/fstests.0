Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6B1C54EBD
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Jan 2023 19:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjAFTDN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 Jan 2023 14:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbjAFTCk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Jan 2023 14:02:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6121576EE3
        for <fstests@vger.kernel.org>; Fri,  6 Jan 2023 11:02:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 101E5B810A7
        for <fstests@vger.kernel.org>; Fri,  6 Jan 2023 19:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761DFC433D2;
        Fri,  6 Jan 2023 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673031725;
        bh=6iMIZwgQsTt/VpHDbxFK3jGkjFXlg7CDB5wk9p81R/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrW/IBsdgE+DpmbVNxg56yTjmoMEpq23Kb9SYVg3SsUr2R8mXuVlfAbDI6SfzLnz1
         VTPyRN/FQrb7SI/KRiro8uwQgXi1J4PCy8bZZYPGSWFmymy0Uciiz2zino6mxRCtYy
         Ob+8RaPWXb7wrCIPQNppSfuzCqyzOq7Rp034iW9Vo3DhblRujv3l5dFe9tSxYxheUQ
         wVbKPf6rLsYYWyqiFVC7FM28m4lXW3WJ8Q0dR07S8Bb4QGsP5IEJHNXLIrpi7SO34C
         dSJhaHxYnMSuo/pJB8DSQIfJmIMX0mBBIBy4IbtRrlSrOPOSGlW9rlPeoc0bGsOug/
         B7WctXN+J6VzA==
Date:   Fri, 6 Jan 2023 19:02:04 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Boyang Xue <bxue@redhat.com>
Cc:     fstests@vger.kernel.org, lczerner@redhat.com
Subject: Re: [PATCH v1] src/stat_test.c: add STATX_DIOALIGN support
Message-ID: <Y7hwLDl+ocQ1Xm/l@gmail.com>
References: <20230104042801.217898-1-bxue@redhat.com>
 <Y7fU4pRA+LHhsMKj@sol.localdomain>
 <CAHLe9YamOY1UJ5Bq0w1ykmG47cztGP1U5CPPD-kiEWtEcFUKtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YamOY1UJ5Bq0w1ykmG47cztGP1U5CPPD-kiEWtEcFUKtg@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 06, 2023 at 07:10:04PM +0800, Boyang Xue wrote:
> I planned to test this functionality by hacking generic/423, which I
> think is a good framework for doing basic statx() validation, like
> 
> ref_dio_mem_align=$(cat /sys/block/<dev>/queue/logical_block_size)
> ref_dio_offset_align=$(($(cat /sys/block/<dev>/queue/dma_alignment)+1))
> ...
> check_stat $TEST_DIR/$seq-file \
>    stx_dio_mem_align=$ref_dio_mem_align \
>    stx_dio_offset_align=$ref_dio_offset_align
> 
> I think this is adequate for a basic correctness test?

Not in general.  The logical_block_size and dma_alignment+1 of the block device
(assuming the filesystem has a block device, and only one of them...) are only
the *typical* values for stx_dio_mem_align and stx_dio_offset_align.  They are
*not* the guaranteed values, since the DIO support and alignment restrictions
are filesystem-specific.  They depend on the filesystem type, mkfs options,
mount options, kernel version, block device, and other things.  So if you add
the above, it will make generic/423 fail in various cases.

This problem is the whole reason that STATX_DIOALIGN was added: it provides a
way to query DIO support and alignment restrictions.  If there was already
another way to *reliably* query DIO support and alignment restrictions, then
there would have been no need to add STATX_DIOALIGN.

Nonetheless, see my previous email for some ideas about tests of STATX_DIOALIGN
that might be possible.

Another idea is to test STATX_DIOALIGN on a block device node, not a regular
file.  The results from block devices are more predictable; currently
STATX_DIOALIGN on a block device always reports logical_block_size and
dma_alignment+1.  Though, that could still change in future kernel versions.

- Eric

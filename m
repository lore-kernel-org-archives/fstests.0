Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D372C433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  2 May 2022 04:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiEBEH7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 2 May 2022 00:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiEBEH6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 May 2022 00:07:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0525D5F76
        for <fstests@vger.kernel.org>; Sun,  1 May 2022 21:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54F43B81052
        for <fstests@vger.kernel.org>; Mon,  2 May 2022 04:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFEEC385AC;
        Mon,  2 May 2022 04:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651464268;
        bh=Y0hLPz+SZ8OOdgi4ouyQoERSroZ7/zMuvB66GchBY7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KPIVz4MEc4IYg4YsW1GD/cJNWY+lzpwFOLfKrkBZc16mADPUczJ0AmlcimrN1gZgd
         psE+izoj6gMPV1MFs5DcprP+JZb/Rj939sWMUIw5FwdWKf8c7zWkjb93mUhKUwsbls
         57arhRmYytbQdFCH1agecez3nYUzZqsZ+CimUZs6GMQf888MbYkBCp1Bwvq8nOf/y2
         W+nLBFhI/yRgL2hXh0T+wSVylP19b5J7sYfho1alzeSnGSfonEkCCKD0aMUVKU1NvK
         zRdOVbtcvp7A+WZaSmS9ixzoYlpGAnSEkGSFMix9kuGwlM0hz88NRO102z0Y1BOQEx
         G//YexFrJ+36Q==
Date:   Mon, 2 May 2022 12:04:22 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 0/2] Annonate fstests with possible reasons for failure
Message-ID: <20220502040422.fhtbl6fqhq53ucpc@zlang-mailbox>
Mail-Followup-To: fstests@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
References: <20220419125637.2502181-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419125637.2502181-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 19, 2022 at 03:56:35PM +0300, Amir Goldstein wrote:
> Zorro,
> 
> This series adresses your review comments on v1.
> Specifically, I dropped the controversial patch #3 and the
> SKIP_KNOWN_ISSUES run option.
> 
> To clarify, multiple annotations could be used in each test,
> for example:
>  _fixed_by_kernel_commit 09889695864 xfs: foo
>  _fixed_by_kernel_commit 46464565465 ext4: bar
>  _fixed_by_git_commit e2fsprogs 62464626 e2fs: baz
>  _fixed_in_version xfsprogs v5.15
> 
> On test failure, all the hints will be printed to output as *possible*
> reason for failure.
> 
> These annotation and printed hints are inspired by a similar LTP feature.
> 
> These annotation could be used by testers to auto-generate expunge list
> for testing stable kernels from the information in _fixed_by_kernel_commit
> and _fixed_in_kernel_version. This trivial task is left is an excercise.

I've reviewed V1 patchset, and keep V2 2 weeks here to get more review points.
if there's not objection or suggestion, I'll merge this change in next fstests
release.

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 
> Changes since v1:
> - Rename s/_known_issue_before_kernel/_fixed_in_kernel_version (zlang)
> - Add generic helpers for non-kernel fixes (zlang)
> - Drop _known_issue_on_fs (zlang)
> - Clarify multiple hints are allowed (tytso)
> 
> Amir Goldstein (2):
>   common: support black listing fs in _supported_fs()
>   common: print hints for reasons of test failures
> 
>  check             | 10 ++++++++-
>  common/preamble   |  2 +-
>  common/rc         | 57 +++++++++++++++++++++++++++++++++++++++--------
>  tests/generic/500 |  3 +--
>  tests/generic/631 |  3 +--
>  tests/generic/679 |  3 +--
>  tests/overlay/009 |  3 +++
>  tests/overlay/010 |  3 +++
>  tests/overlay/014 |  2 ++
>  tests/overlay/016 |  4 +++-
>  tests/overlay/017 |  4 +++-
>  tests/overlay/018 |  4 +++-
>  tests/overlay/020 |  3 +++
>  tests/overlay/022 |  2 ++
>  tests/overlay/029 |  2 ++
>  tests/overlay/038 |  2 ++
>  tests/overlay/041 |  2 ++
>  tests/overlay/042 |  3 +++
>  tests/overlay/043 |  4 +++-
>  tests/overlay/044 |  4 +++-
>  tests/overlay/054 |  3 +++
>  tests/overlay/055 |  3 +++
>  tests/overlay/063 |  3 +++
>  tests/overlay/065 |  4 ++++
>  tests/overlay/067 |  3 +++
>  tests/overlay/070 |  4 +++-
>  tests/overlay/071 |  4 +++-
>  tests/overlay/072 |  2 ++
>  tests/overlay/074 |  5 +++++
>  tests/overlay/077 |  5 +++++
>  tests/overlay/078 |  1 +
>  31 files changed, 133 insertions(+), 24 deletions(-)
> 
> -- 
> 2.25.1
> 

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780F7C433EF
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Sep 2021 10:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA4A610CB
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Sep 2021 10:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbhIGKhm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:37:42 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:60874 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242458AbhIGKhm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Sep 2021 06:37:42 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 3161F104E3CF;
        Tue,  7 Sep 2021 20:36:34 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mNYSu-009h5L-OZ; Tue, 07 Sep 2021 20:36:32 +1000
Date:   Tue, 7 Sep 2021 20:36:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] common/rc: Check SCRATCH_DEV in _require_dm_target()
Message-ID: <20210907103632.GF1756565@dread.disaster.area>
References: <20210907074116.1799114-1-shinichiro.kawasaki@wdc.com>
 <20210907081556.GE1756565@dread.disaster.area>
 <20210907092843.ludgrxfo34xud3ue@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907092843.ludgrxfo34xud3ue@shindev>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=wnxR4--n_QdIfywmGfMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 07, 2021 at 09:28:44AM +0000, Shinichiro Kawasaki wrote:
> On Sep 07, 2021 / 18:15, Dave Chinner wrote:
> > On Tue, Sep 07, 2021 at 04:41:16PM +0900, Shin'ichiro Kawasaki wrote:
> > > When SCRATCH_DEV is not set and the test case does not call
> > > _require_scratch*() before _require_dm_target(), _require_block_device()
> > 
> > That is the bug that needs fixing.
> 
> Thanks for the comment. Do you mean the test cases (generic/628 and generic/629)
> need fix to call _require_scratch*() before _require_dm_target()? I think that

Yes.

Indeed,  generic/628 does:

_require_dm_target error
_require_scratch_reflink

and g629 does:

_supported_fs generic
_require_dm_target error
_require_xfs_io_command "chattr" "s"
_require_xfs_io_command "copy_range"
_require_scratch

i.e. these two cases are just incorrectly ordered require rules.

Oh, and a quick check of all the dm_target tests:

$ git grep -l _require_dm_target tests/ > t.t
$ git grep -l _require_scratch `cat t.t` > t.tt
$ diff -u t.t t.tt
$

Every test that has require_dm_target rule also has a
_require_scratch rule in it somewhere...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62AEC43217
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 02:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03946113C
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 02:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347339AbhIHC7W (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Sep 2021 22:59:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45567 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347363AbhIHC7V (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Sep 2021 22:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631069895; x=1662605895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7vhGYXLmmOkphcwVUQ3th+RypI6+GEuS/FofoMfxCKw=;
  b=PJjRlgv2yAJcFnRczuxgc1U5in0cNQnLnuyGa8TXqQgsmW0JdMxCPgyI
   DOoNmBhlZDE38FjFnEn1/j0e2D46Rmb8IsQjijNeI125NLMvwqpX0zcUB
   EYH3q6zaaD0yVbcygmsxVr1D47wCRCdxn2j7O7+vExkKXscGKAverInDh
   r3BSUpmGqq2b+nVQX3gxOjaU3Mw9fE5GRUftNvxi57XHf2dKFy3SaWqYB
   0/JhTlz0ozo2ZJ3ISGaYvyVuQmMXzbrxUSxy2S5h65prJTaydpkbpT7uW
   DJtxHxSb/lmaB54TnAKOI/sAaf1Sq7jNgZkKFCmYwIN9KWfyeGxfj8sbs
   w==;
X-IronPort-AV: E=Sophos;i="5.85,276,1624291200"; 
   d="scan'208";a="179963561"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2021 10:57:44 +0800
IronPort-SDR: oapgX5QzD/hWYp7boZ90J6ch9Q7jw7tQmSHOnvcmTHE7kh6MpImwVl6EEYYA4Fj13yQwfSmIYo
 hzwwXxP6gBuVg0MEDh8twJQv2obMGHvkcg9mXBhiWjYpjuKEO8imr84MfuQH+m75AHraSG9rDz
 V2Q78Iyqa3T6iRYpHDXkKfBE1exRqHDcCYuydmOmzM9ccBAr7DdatTAzDwvXNYk8S4h5dq4ZZl
 aA8c6oQak0YqcoPRSOnfT9XFjaZPWOa54ndT2ngU4tG6cs0vSPIVpOt8ZOtljlxWB/5SoH9Wmg
 d+Q+vI58ZbSy7VoKdF8qUFwV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 19:32:42 -0700
IronPort-SDR: EMiM7xwSC5G0k1baresuzpQhYJ7Sx1zEN6TIH35sFxKfcUCYd5w0SNTkFgQ016EgRlS/T6oyGT
 9BDUbIr1ZbXkhxmivtbXzPsgVFFtrxbDy/F9y4Ytb9Fj8jlNiGNOgYZBkPrqXKkzY3g5SSqpiH
 iUSBQmuf6bRPyak3vwt1i4dhZb0h5aou2a01QsY0u7HqKafjKkf1HdK/uQZF/Yv6Q6fdtUgcG+
 S2EHvvTkReTQbb70/3H0iBKwJ/o5z3EkSjM1nNskyojPxNvsOkVySbg4hJTGlHTNBWJPPXuQBu
 L4k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 19:57:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4H46J73yrVz1RvlY
        for <fstests@vger.kernel.org>; Tue,  7 Sep 2021 19:57:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=in-reply-to:content-disposition
        :content-type:mime-version:references:message-id:subject:to:from
        :date; s=dkim; t=1631069862; x=1633661863; bh=7vhGYXLmmOkphcwVUQ
        3th+RypI6+GEuS/FofoMfxCKw=; b=HfkicWaedRy6y1QFZTF/KQnyQVFBoeTW7q
        cWxiOqOxqLJP3YH1GGPI93O90K5vZjpT6snITakLGK2SrcjYA+atUJ8DF6gYC9wR
        OyYQNWPVE1gz/u5RpyEkHgMZkRBFvGwToDTg2/ePZ+xtZXAN6SSipJPcq0qJTYbp
        7o1XBwh1mqc1koUIP/CHKivlYdDTmXbe+UR7aTfKFsaVxDmL+1wxRB/K7glC7AFJ
        4ipZpLNnrO7Gk2gm5O6b67VT/Npt6McYmAn8FAfcD2y0A5mLcq35oAiNzPu8fRej
        sW61OOKVoMxJmt5pgron5IaqYjQBY8DnCShDOJJ7JacmmtuaU7Mw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id f--gnfR7UGIz for <fstests@vger.kernel.org>;
        Tue,  7 Sep 2021 19:57:42 -0700 (PDT)
Received: from shindev (shindev.dhcp.fujisawa.hgst.com [10.149.52.173])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4H46J56YFqz1RvlR;
        Tue,  7 Sep 2021 19:57:41 -0700 (PDT)
Date:   Wed, 8 Sep 2021 11:57:39 +0900
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] common/rc: Check SCRATCH_DEV in _require_dm_target()
Message-ID: <20210908025739.chiuor5dzn5icdku@shindev>
References: <20210907074116.1799114-1-shinichiro.kawasaki@wdc.com>
 <20210907081556.GE1756565@dread.disaster.area>
 <20210907092843.ludgrxfo34xud3ue@shindev>
 <20210907103632.GF1756565@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907103632.GF1756565@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sep 07, 2021 / 20:36, Dave Chinner wrote:
> On Tue, Sep 07, 2021 at 09:28:44AM +0000, Shinichiro Kawasaki wrote:
> > On Sep 07, 2021 / 18:15, Dave Chinner wrote:
> > > On Tue, Sep 07, 2021 at 04:41:16PM +0900, Shin'ichiro Kawasaki wrote:
> > > > When SCRATCH_DEV is not set and the test case does not call
> > > > _require_scratch*() before _require_dm_target(), _require_block_device()
> > > 
> > > That is the bug that needs fixing.
> > 
> > Thanks for the comment. Do you mean the test cases (generic/628 and generic/629)
> > need fix to call _require_scratch*() before _require_dm_target()? I think that
> 
> Yes.
> 
> Indeed,  generic/628 does:
> 
> _require_dm_target error
> _require_scratch_reflink
> 
> and g629 does:
> 
> _supported_fs generic
> _require_dm_target error
> _require_xfs_io_command "chattr" "s"
> _require_xfs_io_command "copy_range"
> _require_scratch
> 
> i.e. these two cases are just incorrectly ordered require rules.
> 
> Oh, and a quick check of all the dm_target tests:
> 
> $ git grep -l _require_dm_target tests/ > t.t
> $ git grep -l _require_scratch `cat t.t` > t.tt
> $ diff -u t.t t.tt
> $
> 
> Every test that has require_dm_target rule also has a
> _require_scratch rule in it somewhere...

Thanks for the clarification. I will repost a patch to fix the order of
_require_scratch* and _require_dm_target in generic/{628,629}.

Regarding the future test cases, I think we can improve error check and error
message in _require_dm_target. I will post another patch for it. Comment on it
will be appreciated also.

-- 
Best Regards,
Shin'ichiro Kawasaki

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67BCC2D0A3
	for <linux-fstests@archiver.kernel.org>; Mon,  9 Nov 2020 23:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9816F2074F
	for <linux-fstests@archiver.kernel.org>; Mon,  9 Nov 2020 23:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKIXO7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 9 Nov 2020 18:14:59 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41929 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729336AbgKIXO7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Nov 2020 18:14:59 -0500
X-Greylist: delayed 1758 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2020 18:14:58 EST
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B286558BC7A;
        Tue, 10 Nov 2020 09:45:38 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kcFur-009TVV-UE; Tue, 10 Nov 2020 09:45:37 +1100
Date:   Tue, 10 Nov 2020 09:45:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] open_by_handle: Don't use MAX_HANDLE_SZ
Message-ID: <20201109224537.GA2256367@dread.disaster.area>
References: <20201029040338.238990-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029040338.238990-1-palmerdabbelt@google.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10 a=7-415B0cAAAA:8
        a=8Ui4nEJ1yS2e1LEi8yUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 28, 2020 at 09:03:39PM -0700, Palmer Dabbelt wrote:
> When I compile this normally I end up with the definition of
> MAX_HANDLE_SZ, but when I compile it in a minimal buildroot-based
> environment I don't.  I'm not sure where this is supposed to come from,
> but as of 3f4760c2 ("open_by_handle: add option -z to query file handle
> size") it appears to be unnecessary.

Hmmm - it should be trivial to find where it comes from with grep:

$ grep -R MAX_HANDLE_SZ /usr/include
/usr/include/x86_64-linux-gnu/bits/fcntl-linux.h:# define	MAX_HANDLE_SZ	128
$

IOWs, MAX_HANDLE_SZ is defined via:

#include <fcntl.h>

which src/open_by_handle.c already includes.

IOWs, this looks like a problem with your build root environment not
defining MAX_HANDLE_SZ correctly, not a problem with fstests.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

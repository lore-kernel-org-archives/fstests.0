Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210D4C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Feb 2022 10:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbiBJKXA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 10 Feb 2022 05:23:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbiBJKWy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Feb 2022 05:22:54 -0500
X-Greylist: delayed 364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 02:22:08 PST
Received: from outbound-smtp36.blacknight.com (outbound-smtp36.blacknight.com [46.22.139.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395FA1006
        for <fstests@vger.kernel.org>; Thu, 10 Feb 2022 02:22:08 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp36.blacknight.com (Postfix) with ESMTPS id 8D8FE3231
        for <fstests@vger.kernel.org>; Thu, 10 Feb 2022 10:16:02 +0000 (GMT)
Received: (qmail 19360 invoked from network); 10 Feb 2022 10:16:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Feb 2022 10:16:02 -0000
Date:   Thu, 10 Feb 2022 10:16:00 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     raymond.barbiero.dev@gmail.com, fstests@vger.kernel.org,
        jack@suse.cz, dave@stgolabs.net
Subject: Re: [PATCH 0/4] dbench: few enhancements from mmtests
Message-ID: <20220210101600.GQ3366@techsingularity.net>
References: <20220209221849.434616-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220209221849.434616-1-mcgrof@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 09, 2022 at 02:18:45PM -0800, Luis Chamberlain wrote:
> mmtests [0] also uses dbench, and they actually carry 4 patch delta
> for years. These patches are useful and should not interfere
> with existing uses, so just merge these.
> 
> As noted before, I've put all this and a few of my own fixes
> into my own git tree [1] and I'll be extending dbench there as well
> as I see its not up to date and even debian has dropped packaging
> it as it doesn't compile anymore. The one on my tree compiles more
> than fine now. I'll send a few other fixes after this set.
> 
> Mel, feel free to drop those patches if you want to use my tree :)
> 

Thanks Luis, I expect to migrate mmtests to use your tree relatively soon!

-- 
Mel Gorman
SUSE Labs

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51625C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Mar 2022 23:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiCCXnJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Mar 2022 18:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiCCXnB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Mar 2022 18:43:01 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B81B175875
        for <fstests@vger.kernel.org>; Thu,  3 Mar 2022 15:42:15 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 94EA45319F8;
        Fri,  4 Mar 2022 10:42:13 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nPv5H-001Cwi-Qa; Fri, 04 Mar 2022 10:42:11 +1100
Date:   Fri, 4 Mar 2022 10:42:11 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/1] README: restructure & format building manual
Message-ID: <20220303234211.GH3927073@dread.disaster.area>
References: <20220228202849.183568-1-aalbersh@redhat.com>
 <20220228202849.183568-2-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228202849.183568-2-aalbersh@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62215255
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=0picOS2BLk9-z2kh1SYA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 28, 2022 at 09:28:49PM +0100, Andrey Albershteyn wrote:
> The commands for package managers for both Ubuntu and RHEL weren't
> up-to-date. A few packages doesn't exist anymore or missing from the
> latest repositories (e.g. liburing-devel, btrfs-progs-devel).
> Ubuntu's list missed a few packages listed in RHEL's list. There are
> a few repeating steps. The indent of avaliable environment variables
> is not clear.
> 
> This patch:
> - Update package dependencies for Ubuntu/Debian/RHEL/CentOS/Fedora
> - Unify list of packages between Ubuntu/Debian and RHEL/CentOS/Fedora
> - Add list of tool packages for other FS
> - Add links to tools not in the standard repository for RHEL/CentOS
> - Drop xfsprogs-qa-devel reference for old systems
> - Replace note about EPEL with installation step with link to Fedora
>   manual
> - Add configuration examples in 'Setup Environment'
> - Small clarification details, such as size of the partition and
>   KCONFIG_PATH description
> - Removal of repeating steps (install administrative tools,
>   partitions content)
> - Restructuring and formatting of "BUILDING THE FSQA SUITE" section
> - Drop IRIXDEV references in variable set up
> - Variables in 'Additional setup' divided into groups
> - Move fsqa user/group creation and udf_test to 'Setup Environment'
>   section
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  README | 372 ++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 235 insertions(+), 137 deletions(-)

Much nicer!

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

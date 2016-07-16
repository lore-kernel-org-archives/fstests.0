Received: from mx1.redhat.com ([209.132.183.28]:42098 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbcGPK2V (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 16 Jul 2016 06:28:21 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A543078EAD
	for <fstests@vger.kernel.org>; Sat, 16 Jul 2016 10:28:20 +0000 (UTC)
Date: Sat, 16 Jul 2016 18:28:18 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 0/6 v3] xfstests: some small fixes and mkfs validation
 test
Message-ID: <20160716102818.GM2432@eguan.usersys.redhat.com>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 14, 2016 at 02:43:28PM +0200, Jan Tulak wrote:
> This set is a merge of all my recent patches. The reason for the merge is that
> the patches are sequentially dependent and making a set is the safest way of
> ensuring their correct order after a merge.
> 
> One patch, "filename handling - fix early wildcard expansion", was
> dropped for now. Patch "add _require_xfs_mkfs_validation to common/rc" is new,
> and update of xfs/096 and input validation tests were changed.
> 
> 
> Jan Tulak (6):
>   xfstests: Fix installation for extended names
>   fstests: filename handling for extended names in ./check was on a
>     wrong place
>   xfstests: remove unused variable
>   xfstests: add _require_xfs_mkfs_validation to common/rc
>   xfstests: update xfs/096 for new behaviour
>   xfstests: Add mkfs input validation tests

I took patch 4 and 5 in this pull-request and left other extended name
related patches for now, due to the .cfg file installation issue.

Thanks,
Eryu

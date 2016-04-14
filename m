Received: from mx1.redhat.com ([209.132.183.28]:33084 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbcDNGuB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Apr 2016 02:50:01 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97DFEC04B308
	for <fstests@vger.kernel.org>; Thu, 14 Apr 2016 06:50:00 +0000 (UTC)
Date: Thu, 14 Apr 2016 14:49:58 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/299: change variable name from "temp" to "tmp" for
 typo error
Message-ID: <20160414064958.GH4675@eguan.usersys.redhat.com>
References: <1460611943-14660-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460611943-14660-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 14, 2016 at 01:32:23PM +0800, Zorro Lang wrote:
> In xfs/299, project IDs are in $tmp.projid file. But there's one
> line code try to use $temp.projid. Fortunately, it doesn't bring
> any problems until now, but if keep using $temp.projid it really
> don't make sense.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>

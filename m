Received: from mx1.redhat.com ([209.132.183.28]:50307 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbcF3MAl (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 08:00:41 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFC687F6A8
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 12:00:40 +0000 (UTC)
Date: Thu, 30 Jun 2016 20:00:38 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v8] generic/362-370: Add richacl tests
Message-ID: <20160630120038.GA23649@eguan.usersys.redhat.com>
References: <1467118046-27030-1-git-send-email-agruenba@redhat.com>
 <1467118046-27030-2-git-send-email-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467118046-27030-2-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 28, 2016 at 02:47:26PM +0200, Andreas Gruenbacher wrote:
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

The tests look fine to me. I compiled your richacl kernel & richacl
tools & xfsprogs and tested them on XFS on ppc64 host, and they all
passed. I've queued them up for next pull request. Thanks!

Eryu

Received: from mx1.redhat.com ([209.132.183.28]:49169 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbcEWJMF (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 23 May 2016 05:12:05 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 370C36265D
	for <fstests@vger.kernel.org>; Mon, 23 May 2016 09:12:05 +0000 (UTC)
Date: Mon, 23 May 2016 17:12:00 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] filter stripe width details from repair
Message-ID: <20160523091200.GK5140@eguan.usersys.redhat.com>
References: <0f397d04-157b-4a56-0100-c12628322477@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f397d04-157b-4a56-0100-c12628322477@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, May 19, 2016 at 04:19:51PM -0500, Eric Sandeen wrote:
> Several golden outputs have:
> 
> > Note - stripe unit (0) and width (0) fields have been reset.
> 
> but it's entirely possible for this to be non-zero,
> which then fails to match and fails the test.
> 
> Filter this repair output and fix the golden files.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good to me.

Reviewed-by: Eryu Guan <eguan@redhat.com>

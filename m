Received: from mx1.redhat.com ([209.132.183.28]:57656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbdEDJ6g (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 May 2017 05:58:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B5707D4E0
        for <fstests@vger.kernel.org>; Thu,  4 May 2017 09:58:36 +0000 (UTC)
Received: from localhost (dhcp-12-173.nay.redhat.com [10.66.12.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C68B318380
        for <fstests@vger.kernel.org>; Thu,  4 May 2017 09:58:35 +0000 (UTC)
Date: Thu, 4 May 2017 17:58:34 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] tasks-upstream: remove xfs finobt tests and add
 sparse inode tests
Message-ID: <20170504095834.GM7250@eguan.usersys.redhat.com>
References: <20170504095239.15901-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170504095239.15901-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 04, 2017 at 05:52:38PM +0800, Eryu Guan wrote:
> finobt feature is enabled by default in upstream xfsprogs, there's
> no need to test finobt explicitly.
> 
> Instead, test sparse inode feature, which is off by default.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Sorry for the noise! Sent to wrong list, please ignore these patches.

(my finger typed fstests@vger.kernel.org automatically without
thinking..)

Eryu

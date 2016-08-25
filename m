Received: from mx1.redhat.com ([209.132.183.28]:49998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751393AbcHYEgl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 Aug 2016 00:36:41 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50F31C049D52
        for <fstests@vger.kernel.org>; Thu, 25 Aug 2016 04:11:13 +0000 (UTC)
Received: from localhost (dhcp-13-153.nay.redhat.com [10.66.13.153])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7P4BCTp007543
        for <fstests@vger.kernel.org>; Thu, 25 Aug 2016 00:11:12 -0400
Date: Thu, 25 Aug 2016 12:11:11 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] common/rc: introduce _overlay_mount_dirs helper
Message-ID: <20160825041111.GW27776@eguan.usersys.redhat.com>
References: <1470741381-32610-1-git-send-email-eguan@redhat.com>
 <20160812033342.GS27776@eguan.usersys.redhat.com>
 <20160819030517.GE27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160819030517.GE27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 19, 2016 at 11:05:17AM +0800, Eryu Guan wrote:
> On Fri, Aug 12, 2016 at 11:33:42AM +0800, Eryu Guan wrote:
> > On Tue, Aug 09, 2016 at 07:16:20PM +0800, Eryu Guan wrote:
> > > Introduce a new _overlay_mount_dirs() helper to do the actual
> > > overlay mount operation and factor _overlay_scratch_mount and
> > > _overlay_mount code to use a single implemention of
> > > _overlay_mount_dirs(). Also convert all bare mount of overlay in
> > > tests to use it.
> > > 
> > > Suggested-by: Dave Chinner <dchinner@redhat.com>
> > > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > 
> > Ping on this one, hope I can push this out this week.
> 
> Ping again.

Ping for the third time :)

Thanks,
Eryu

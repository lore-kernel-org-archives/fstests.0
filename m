Received: from mx1.redhat.com ([209.132.183.28]:54862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbdDOMnJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 15 Apr 2017 08:43:09 -0400
Date: Sat, 15 Apr 2017 20:43:07 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] test FIEMAP on extended attribute blocks
Message-ID: <20170415124307.GE8951@eguan.usersys.redhat.com>
References: <20170414220658.GC5083@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170414220658.GC5083@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 14, 2017 at 03:06:58PM -0700, Darrick J. Wong wrote:
> Make sure that FIEMAP produces some output when we add enough xattrs
> to force the xattrs to be stored in an external block.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks for resending! I've already queued it for the comming update.

Thanks,
Eryu

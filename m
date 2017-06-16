Received: from mx1.redhat.com ([209.132.183.28]:50638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbdFPGer (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 16 Jun 2017 02:34:47 -0400
Date: Fri, 16 Jun 2017 14:34:45 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] ext4: fsmap tests
Message-ID: <20170616063445.GH17436@eguan.usersys.redhat.com>
References: <20170602225220.GA5634@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170602225220.GA5634@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hi Darrick,

On Fri, Jun 02, 2017 at 03:52:20PM -0700, Darrick J. Wong wrote:
> Test the GETFSMAP ioctl against ext4.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

I'm planning to merge this patch after merging Jeff's patch that adds
external log dev support to ext4 (Jeff's patchset is still in its review
cycle), if you're not in a hurry. Please let me know if you'd like to
see ext4 fsmap tests sooner.

Thanks,
Eryu

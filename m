Received: from mail-pl1-f193.google.com ([209.85.214.193]:36615 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLOk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 May 2019 07:14:40 -0400
Date: Fri, 3 May 2019 19:14:33 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: try use forget to unregister device
Message-ID: <20190503111433.GD15846@desktop>
References: <1552988980-25710-1-git-send-email-anand.jain@oracle.com>
 <20190402081946.24838-1-anand.jain@oracle.com>
 <20190426163542.GW20156@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426163542.GW20156@twin.jikos.cz>
Sender: fstests-owner@vger.kernel.org
To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 26, 2019 at 06:35:42PM +0200, David Sterba wrote:
> On Tue, Apr 02, 2019 at 04:19:46PM +0800, Anand Jain wrote:
> > Some btrfs test cases use btrfs module-reload to unregister devices in
> > the btrfs kernel. The problem with the module-reload approach is, if test
> > system contains btrfs as rootfs, then you can't run these test cases.
> > 
> > Patches [1] introduced btrfs forget feature which can unregister devices
> > without the module-reload approach.
> > 
> >  [1]
> >  btrfs-progs: device scan: add new option to forget one or all scanned devices
> >  btrfs: introduce new ioctl to unregister a btrfs device
> > 
> > And this patch makes relevant changes in the fstests to use this new
> > feature, when available.
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> > v2:
> >  Update change log.
> >  Rename _require_btrfs_forget_if_not_fs_loadable() to _require_btrfs_forget_or_module_loadable()
> >  Rename _btrfs_forget_if_not_fs_reload() to _btrfs_forget_or_module_reload()
> 
> Reviewed-by: David Sterba <dsterba@suse.com>

The patch has already been applied & pushed to upstream, thanks for the
review all the same!

Thanks,
Eryu

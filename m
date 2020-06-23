Return-Path: <SRS0=gdhN=AE=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F412C433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Jun 2020 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8234C2072E
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Jun 2020 18:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbgFWSIE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:08:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:10223 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732549AbgFWSIE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 Jun 2020 14:08:04 -0400
IronPort-SDR: YcNXmBGTEFAZu8zDxMY+EeTeRaTxtSuIUJqi9UhFRUTFNV9bXrggmquHd59NIyfvJnNwj8YMx1
 m6H9ZQd7RFvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="143262475"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="143262475"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 11:08:03 -0700
IronPort-SDR: V8trUnLxWfhY2grgvbj801ZMmPZKAFC+Y3qSz7b+21WLCkDvqTpgdYLdYD9nZdzfx7w8UnF3l4
 TaIj+eZFKuzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="478956199"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jun 2020 11:08:03 -0700
Date:   Tue, 23 Jun 2020 11:08:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     Xiao Yang <ice_yangxiao@163.com>, fstests@vger.kernel.org,
        darrick.wong@oracle.com
Subject: Re: [PATCH v2 6/6] xfs/260: Move xfs/260 to generic
Message-ID: <20200623180803.GE3910394@iweiny-DESK2.sc.intel.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
 <20200617093204.20838-7-ice_yangxiao@163.com>
 <20200617214857.GN4160762@iweiny-DESK2.sc.intel.com>
 <a2b565a7-7ff8-7201-1921-4724d8117cbb@163.com>
 <20200619151511.GR4160762@iweiny-DESK2.sc.intel.com>
 <5EF1C293.4010104@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EF1C293.4010104@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 23, 2020 at 04:51:31PM +0800, Xiao Yang wrote:
> On 2020/6/19 23:15, Ira Weiny wrote:
> > On Thu, Jun 18, 2020 at 11:35:56PM +0800, Xiao Yang wrote:
> > > On 6/18/20 5:48 AM, Ira Weiny wrote:
> > > > On Wed, Jun 17, 2020 at 05:32:04PM +0800, Xiao Yang wrote:
> > > > > From: Xiao Yang<yangx.jy@cn.fujitsu.com>

[snip]

> > > >    }
> > > > @@ -124,17 +151,11 @@ do_tests()
> > > >    # make xfs aligned for PMD fault testing
> > > >    _scratch_mkfs_geom $(_get_hugepagesize) 1>>  $seqres.full 2>&1
> > > > -# mount with dax option
> > > > -_scratch_mount "-o dax"
> > > > -
> Hi Ira,
> 
> Why do you want to remove this combination(i.e. test per-inode DAX flag
> under mounting with dax option) ?
> Is it because mounting with dax option ignore FS_XFLAG_DAX flag?
> I think it is a reasonable combination. :-)

Yes running with the DAX mount option really does not test anything IMO.

> 
> > > >    tsize=$((128 * 1024 * 1024))
> > > > -do_tests
> > > > -_scratch_unmount
> > > > -
> > > >    # mount again without dax option
> > > >    export MOUNT_OPTIONS=""
> > > > -_scratch_mount
> > > > +_scratch_mount "-o dax=inode"
> > > >    do_tests
> > > >    # success, all done
> 
> Could we keep _scratch_mount without dax so that this test can run on both
> old and new kernel?
> See the following reasons:
> 1) FS_XFLAG_DAX was introduced by commit 58f88ca("xfs: introduce per-inode
> DAX enablement") since 2017.
> 2) _scratch_mount with dax=inode is equal to _scratch_mount without dax.

I suppose that would be ok.  But being generic what happens when this runs on
FS's which don't have the FS_XFLAG_DAX flag?  is it ignored?

FWIW I believe that any FS (which includes older kernels) which do not support
dax=inode have no need for this test to run.  The use of FS_XFLAG_DAX on older
xfs does not do anything and simply does not exist elsewhere.  Only FS's which
support dax=inode have behavior which needs to be tested IMO.

Ira

> 
> Best Regards,
> Xiao Yang
> > 
> > .
> > 
> 
> 
> 

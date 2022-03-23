Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC27C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Mar 2022 13:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244284AbiCWN0d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiCWN0c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Mar 2022 09:26:32 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E5D46156
        for <fstests@vger.kernel.org>; Wed, 23 Mar 2022 06:24:59 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220323132454epoutp029fd532641d5100103a4150b6379f8fc7~fBV8t4zk62565825658epoutp02r
        for <fstests@vger.kernel.org>; Wed, 23 Mar 2022 13:24:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220323132454epoutp029fd532641d5100103a4150b6379f8fc7~fBV8t4zk62565825658epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648041895;
        bh=uMECmOWJ9x36o3aYlJx4OlIMPZGnmUU0Z8l30RR1GbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tWoGk8m7foGEmEEjCVyXMz+1J8hkWFkQ9rnm0HIp7JOHlnn4AMZbMmL+cultYsRuf
         pfYKKivogN+0Cn4DlVdtPbFhHu9iuf+G/MN5GB7IBYrGkRmKsDlmZT19CXRJLKlFvy
         aY7FiFimcjrP6PQfL/+uC+2E7C+iEqD3eVKV5X4U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220323132454epcas5p2b7baeee19b022b3c14b6b22df3448b1f~fBV8imyHc1970519705epcas5p2s;
        Wed, 23 Mar 2022 13:24:54 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KNpxD3C7Qz4x9Ps; Wed, 23 Mar
        2022 13:24:48 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.96.12523.D9F1B326; Wed, 23 Mar 2022 22:24:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220323121220epcas5p369b8b342c923c3d6e39fda247696c603~fAWlijTSl1788317883epcas5p3N;
        Wed, 23 Mar 2022 12:12:20 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220323121220epsmtrp26df59dd738eddfcd0868ea99d6e105eb~fAWlh39aw0309203092epsmtrp2j;
        Wed, 23 Mar 2022 12:12:20 +0000 (GMT)
X-AuditID: b6c32a4a-5b7ff700000030eb-c8-623b1f9d55b7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.02.03370.4AE0B326; Wed, 23 Mar 2022 21:12:20 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220323121220epsmtip1e082e91a2b2cd487abb3f95f5e2ddabd~fAWk3gDTs0792907929epsmtip1j;
        Wed, 23 Mar 2022 12:12:19 +0000 (GMT)
Date:   Wed, 23 Mar 2022 17:37:18 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, nitheshshetty@gmail.com
Subject: Re: [PATCH] generic/108: use sysfs values for logical,physical
 block size in scsi_debug
Message-ID: <20220323120718.GC19899@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220322160756.GM8200@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmuu5ceeskgyfH9CwuP+GzON2yl91i
        x5NGRgdmj52z7rJ7bFrVyebxeZNcAHNUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6h
        pYW5kkJeYm6qrZKLT4CuW2YO0B4lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJ
        gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG2YNbWQqWSVe8ufifrYHxo2gXIyeHhICJxNt5n5m6
        GLk4hAR2M0osbH7DCJIQEvjEKHH6ewRE4jOjxP2XJ9hgOub2tzFCJHYxSkz+2wjV/oxRYvGC
        rewgVSwCqhJ/PtwE6uDgYBPQljj9nwMkLCKgKXHk2zUmEJsZaFD3uuOsILawQJLEuk99YDav
        gK7E70VLGSFsQYmTM5+wgNicQPF5W5eC9YoKKEsc2HYcbK+EwDF2iW1PO6Cuc5H4faSVFcIW
        lnh1fAs7hC0l8fndXjaIhm5GiR9n7kN1z2CUaJ7QDNVtL3Fxz1+o8zIl7u1dwggRl5WYemod
        VJxPovf3EyaIOK/EjnkwtrLEmvULoOZISlz73ghle0hs2rGTGRJE3xgl1n38yziBUX4Wkvdm
        IdkHYetILNj9iW0WMPSYBaQllv/jgDA1Jdbv0l/AyLqKUTK1oDg3PbXYtMAoL7UcHuXJ+bmb
        GMEJUctrB+PDBx/0DjEycTAeYpTgYFYS4V38wTxJiDclsbIqtSg/vqg0J7X4EKMpMLYmMkuJ
        JucDU3JeSbyhiaWBiZmZmYmlsZmhkjjv6fQNiUIC6YklqdmpqQWpRTB9TBycUg1M3M+3Z32V
        9Hef+ERpu0kom6LV196fmz3i3Pv7VN/mBN6ulfgf+sbzNvf5NN1Jgb6XF8TeXyB/8kJB6p+Z
        V5MKV58p8tjYpKXsEKy/OkbMymS/bn86453ggCuBkcZf5TwlZ0f8q5nw3qyCwcr7XzQXj/z/
        zIUWVo+7lt6canzKY9f8qPRvG0R+RigknNdxX77v90Ox9ccP6uf45s0xOMzB7belTEhFJ/uq
        hvy0n0e551xX9j994/vPa8tum53etyFh+bU3nf0eHw8dOXnX4+uin8HbZ23W5fZ/kH3we5HD
        L+YTjAxMyw5Xy0xbdp5zbajbriWzPnCvKlAWFDkpxlKtdTNNoPnQpAvuzAfmcZdtUWIpzkg0
        1GIuKk4EAH5wXOwRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSnO4SPuskg+Vz1C0uP+GzON2yl91i
        x5NGRgdmj52z7rJ7bFrVyebxeZNcAHMUl01Kak5mWWqRvl0CV8amt59YCh5LVHw5ndDAeFy4
        i5GTQ0LARGJufxtjFyMXh5DADkaJ/iV/WSESkhLL/h5hhrCFJVb+e84OUfSEUeJ4ezNYgkVA
        VeLPh5tsXYwcHGwC2hKn/3OAhEUENCWOfLvGBGIzAy3oXnccbKawQJLElX+XwGxeAV2J34uW
        Qi3+wSgx/9g1qISgxMmZT1ggmrUkbvx7yQQyn1lAWmL5P7D5nEC987YuBZsvKqAscWDbcaYJ
        jIKzkHTPQtI9C6F7ASPzKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4BDW0trBuGfV
        B71DjEwcjIcYJTiYlUR4F38wTxLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2
        ampBahFMlomDU6qBaepR4SfbF0pd/nDa7+gOxhZ/97A/n9/uUSgW4zqUw/2Y56qFdQPP06kf
        XtZc1Yw2XxP59Njkngn1/QJXNJSKIrWYU48cWLfIWSB5xabL96Vzeje3/ZP8uXDv1gWep/SL
        j4lba87eev/fi7Y6Ee2jy2WdLj4J+aTCfqnQS22bY+0sm9zXp3rerJk+qaVfv1OdXVrupnp0
        18EJRYfMts7+/XzOzP7b4ioZvD8FnOI2tzU6HmU+UXViUpFx53SVJGueh3lykaI2RmUhXC8E
        l9/7/viU/Ymgn00pUdeKrTzvSorp/mc+KujLtD5qCcPf6C9+qye9N+V855G1QDPq/H8Fxqs1
        Z/liBN4trdMsmzw7XYmlOCPRUIu5qDgRAHlsbL/QAgAA
X-CMS-MailID: 20220323121220epcas5p369b8b342c923c3d6e39fda247696c603
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_1410d7_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd
References: <CGME20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd@epcas5p3.samsung.com>
        <20220301212947.28660-1-nj.shetty@samsung.com>
        <20220321202133.GJ8200@magnolia> <20220322082629.GA32722@test-zns>
        <20220322160756.GM8200@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_1410d7_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Mar 22, 2022 at 09:07:56AM -0700, Darrick J. Wong wrote:
> On Tue, Mar 22, 2022 at 01:56:29PM +0530, Nitesh Shetty wrote:
> >  Mon, Mar 21, 2022 at 01:21:33PM -0700, Darrick J. Wong wrote:
> > > On Wed, Mar 02, 2022 at 02:59:47AM +0530, Nitesh Shetty wrote:
> > > > scsi_debug device used for test, is created with assumption of 512 bytes
> > > > logical and physical block size.
> > > > This causes error in lvcreate step, when SCRATCH_DEV device lba is not
> > > > 512 bytes. This can be solved by reading block size from sysfs of device.
> > > > If sysfs is missing fallback to 512 bytes as default.
> > > > 
> > > > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > > > ---
> > > >  tests/generic/108 | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tests/generic/108 b/tests/generic/108
> > > > index ad43269f..db0e9bd0 100755
> > > > --- a/tests/generic/108
> > > > +++ b/tests/generic/108
> > > > @@ -42,8 +42,11 @@ _require_non_zoned_device $SCRATCH_DEV
> > > >  lvname=lv_$seq
> > > >  vgname=vg_$seq
> > > >  
> > > > +physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> > > > +logical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/logical_block_size)
> > > 
> > > This causes a regression if $SCRATCH_DEV is not a raw block device:
> > > 
> > Acked, I was testing for NVMe device, missed out sda sysfs.
> > Let me see, if I can use other sysfs/utility to get block size of device.
> > 
> > Also I see many 4k LBA tests failing mainly because of setup failure in
> > format command. This is not actually test failure, rather setup failure.
> > So what do you suggest for those type of tests?
> 
> Ideally, fix the ones that can be fixed, and _notrun the rest.
> 

Sure, will send a different patchset.

> > Should I put them in not run status or just report to community so that
> > person with relevant expertise can add a fix?
> 
> For this specific problem I suggest creating a function that finds the
> /sys/block/XXX path for any given block device or partition, and then
> update all the open coded logic to use it.  Something like:
> 
> # Map a block device to its counterpart in sysfs
> _sysfs_block() {
> 	local dev="$1"
> 	local shortdev="$(_short_dev "$dev")"
> 
> 	# Full block devices are simple
> 	local ret="/sys/block/$shortdev"
> 	if [ -e "$ret" ]; then
> 		readlink -m "$ret"
> 		return 0
> 	fi
> 
> 	# Partitions are a little trickier
> 	ret="/sys/class/block/$shortdev"
> 	if [ -e "$ret/partition" ]; then
> 		readlink -m "$ret/.."
> 		return 0
> 	fi
> 
> 	# ???
> 	return 1
> }
> 
> sysfsb=$(_sysfs_block $SCRATCH_DEV)
> physical=$(cat $sysfsb/queue/physical_block_size)
> 
> --D
>

As a alternate, using blockdev utility might reduce and simplify the
changes required. how about below changes ?

-physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
-logical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/logical_block_size)
+physical=`blockdev --getpbsz $SCRATCH_DEV`
+logical=`blockdev --getss $SCRATCH_DEV`

--Nitesh Shetty

------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_1410d7_
Content-Type: text/plain; charset="utf-8"


------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_1410d7_--

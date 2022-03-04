Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AADC433EF
	for <linux-fstests@archiver.kernel.org>; Sat,  5 Mar 2022 14:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiCEOz4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 5 Mar 2022 09:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiCEOz4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 5 Mar 2022 09:55:56 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4438938D8C
        for <fstests@vger.kernel.org>; Sat,  5 Mar 2022 06:55:05 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220305145500epoutp0220814a741ab864f621b80ffad44c59eb~Zg9ePYPZL1020210202epoutp02b
        for <fstests@vger.kernel.org>; Sat,  5 Mar 2022 14:55:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220305145500epoutp0220814a741ab864f621b80ffad44c59eb~Zg9ePYPZL1020210202epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646492100;
        bh=CtKXjL7uVbD5GaAoP4ycveoKRYDCQdv999D1AkCi0uI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YRK3hI482H5a9YfxZ4zvOWbjxvapfe0A1cZWXYj2W5whgdL9ts78Sa0SKIa0yMaiU
         fvE3m4pDaWbMZu43bmHOz06caPGuOxcxOKGMHjLhwZy01PrSQgLy7gp0t4zCmAO9UA
         4CV6YdBsfzvmzcmQiJcDG9K4txAUhuETmvP0Z0Fg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220305145500epcas5p3942cf40b35b049d61c31e971fa7dd7cc~Zg9d36bMK0962709627epcas5p3h;
        Sat,  5 Mar 2022 14:55:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4K9nnW6lP3z4x9Pq; Sat,  5 Mar
        2022 14:54:55 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.2E.05590.FB973226; Sat,  5 Mar 2022 23:54:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220304205324epcas5p301bbe9b25f69f65fede31c6b1568ace2~ZSNGk1wjR1310113101epcas5p3w;
        Fri,  4 Mar 2022 20:53:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220304205324epsmtrp2593d82360e26d41d3e30752197089e69~ZSNGjj3RZ0174301743epsmtrp2H;
        Fri,  4 Mar 2022 20:53:24 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-b4-622379bf14a0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.35.29871.34C72226; Sat,  5 Mar 2022 05:53:23 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220304205322epsmtip21b34dbcfe38e81ddcf988d6dbfea4155~ZSNFdDWnf1321013210epsmtip2f;
        Fri,  4 Mar 2022 20:53:22 +0000 (GMT)
Date:   Sat, 5 Mar 2022 02:18:24 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, nitheshshetty@gmail.com,
        p.raghav@samsung.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        mcgrof@kernel.org
Subject: Re: [PATCH] xfs/205,432,516: read sysfs for mkfs block size instead
 of hardcoded values
Message-ID: <20220304204824.GA5676@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220302225700.GA117704@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmpu7+SuUkg2s3DS323PzManH5CZ/F
        6Za97BZH/79ls7gx4SmjxY4njYwWn5e2sDuwe+ycdZfdY9OqTjaPvi2rGD0+b5ILYInKtslI
        TUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOkBJoSwxpxQo
        FJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ3x9uRM
        loKpKhV7Xxxla2Dsl+1i5OSQEDCR6P6wj7GLkYtDSGA3o8T6G83MEM4nRonj7Z9ZIJxvjBKf
        D15ihWn5dOE7VMteRomZjdvZQRJCAs8YJbpvW4DYLAIqEjcvNjB1MXJwsAloS5z+zwESFhHQ
        lDjy7RoTSC+zQA+jxKzZ+1lAEsICSRIHt25gArF5BXQkmpo3sUDYghInZz4BszkF9CUmvVwB
        doSogLLEgW3HwQZJCPxkl1i7eDY7xHUuErOBAQ9hC0u8Or4FKi4l8fndXjaIhm5GiR9n7kN1
        z2CUaJ7QzAZRZS9xcc9fsDOYBTIkjszuZIKIy0pMPbUOKs4n0fv7CVScV2LHPBhbWWLN+gVQ
        cyQlrn1vhLI9JI7u72GChNdmRolFz/+yT2CUn4XkvVlI9kHYOhILdn9imwUMPmYBaYnl/zgg
        TE2J9bv0FzCyrmKUTC0ozk1PLTYtMM5LLYfHeXJ+7iZGcBLV8t7B+OjBB71DjEwcjIcYJTiY
        lUR4LTUVkoR4UxIrq1KL8uOLSnNSiw8xmgKjayKzlGhyPjCN55XEG5pYGpiYmZmZWBqbGSqJ
        855K35AoJJCeWJKanZpakFoE08fEwSnVwPSktHpPb2PVn0KBPL7O4F/x9Tf/qvM5bPL3soqY
        /dTlysruqgXV1Rsa8z3mW5/l3hOy9ltrk8La37tsrgsslfzI2Pi++sqjiOjTZ7+mKre4Pe5c
        8KdPMmL2xnN2Nxreud/Ldmn+EPqmRPflNVXhpCu3Dv9Wmvv7uXU8+50VDEJ17Gtq65NledJc
        G9hX2zY+YU6T2XHC5rhN69rjy3e+m1i+/peB7LyIh8VcMywtJyVd9V7g/nSNiWs8T03Fy23O
        i/rbpv/bn+aoo/7cZbbB1P+ZH/6wCUk2aUvz2zZOf5x6cKF4l9SFlVsWTMi8b287tVe9fQaj
        +DdtOdEZKi3b/Xselc04r9jz6HKVxJtnbUosxRmJhlrMRcWJAGkGaRErBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvK5zjVKSweX3phZ7bn5mtbj8hM/i
        dMtedouj/9+yWdyY8JTRYseTRkaLz0tb2B3YPXbOusvusWlVJ5tH35ZVjB6fN8kFsERx2aSk
        5mSWpRbp2yVwZUy6dIK94KpixapFTewNjC+kuhg5OSQETCQ+XfjOCGILCexmlNjREQkRl5RY
        9vcIM4QtLLHy33P2LkYuoJonjBIbVi1lA0mwCKhI3LzYwNTFyMHBJqAtcfo/B0hYREBT4si3
        a0wg9cwCPYwSs2bvZwFJCAskSRzcuoEJxOYV0JFoat7EAjF0M6PE422PmSESghInZz4Ba2AW
        0JK48e8l2AJmAWmJ5f/AFnAK6EtMermCFcQWFVCWOLDtONMERsFZSLpnIemehdC9gJF5FaNk
        akFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcNhrae5g3L7qg94hRiYOxkOMEhzMSiK8lpoK
        SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwNTC6C6on
        rNvo0C+q3Z9XW1ZwcSKzkeT3RdLy0uz/LE/3/yqbeEjyz9LjmWcuXhGccq9kzZLzjpzV1/bu
        W3xPPD3j47QPt3tsPH+4NcgUrb9o75JzJiB9SuQN5Ypdc6PXH4zfcLdqo1B4XeYSOVu1qHdx
        s48uWa233Ki/vMFi1udd6+UCP5/kqpJvX+CRHafvm3K5pejAkkvZ0RuCrhW67LJvrSlk/GDW
        bCkjpXLr9n27n6Y39ol47bIxjBEwar/qlylka7TN7PbpPP8qQx6ulQ8W50+Pmzc/e/Vrtcms
        mgqViyP5/zz/Fv7rp43kXv0HMtEM1tufPY8Ovltpvs22acGhW7wzN2R8l/029Vu+EktxRqKh
        FnNRcSIA0QzXr+oCAAA=
X-CMS-MailID: 20220304205324epcas5p301bbe9b25f69f65fede31c6b1568ace2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_df6bb_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220301213529epcas5p2974c84878339d5661336533696d3938f
References: <CGME20220301213529epcas5p2974c84878339d5661336533696d3938f@epcas5p2.samsung.com>
        <20220301213022.28999-1-nj.shetty@samsung.com>
        <20220302225700.GA117704@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_df6bb_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Mar 02, 2022 at 02:57:00PM -0800, Darrick J. Wong wrote:
> On Wed, Mar 02, 2022 at 03:00:22AM +0530, Nitesh Shetty wrote:
> > At present block size of 1024 is hardcoded for mkfs. This creates
> > problem when device block size is more than 1024. So we use sysfs values
> 
> What kinds of problems?
>

I was running the test on NVMe device, which has a LBA of 4096 by default,
so these test fails, not becuase of functionality issues, mainly because of
mkfs failure. mkfs failure is mainly because of assumption of device
LBA is 512 bytes, which is mostly right incase of scsi device.

> > of SCRATCH_DEV, if not found then default to 1024.
> > 
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > ---
> >  tests/xfs/205 | 3 ++-
> >  tests/xfs/432 | 3 ++-
> >  tests/xfs/516 | 3 ++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tests/xfs/205 b/tests/xfs/205
> > index 104f1f45..73e32c4d 100755
> > --- a/tests/xfs/205
> > +++ b/tests/xfs/205
> > @@ -22,7 +22,8 @@ _require_scratch_nocheck
> >  # bitmap consuming all the free space in our small data device.
> >  unset SCRATCH_RTDEV
> >  
> > -fsblksz=1024
> > +physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> 
> For a disk with 512 byte sectors, does this set physical=512?
> 
> The code within the $() really ought to be turned into a helper
> _scratch_dev_phys_block_size or something.
> 

Yes it does, you are right, I see a new failure, since minimum block size for CRC
enabled filesystem is 1K. I will make it minimum of 1024 and actual
device LBA and send v2.

> > +fsblksz=${physical:-1024}
> 
> Filesystem blocksize isn't supposed to be smaller than the physical
> blocksize, but why do you change the fs block size to the physical size?
> 
> 
adressed above. next patch will have fsblksz=min(1024, physical blocksize)

> >  _scratch_mkfs_xfs -d size=$((32768*fsblksz)) -b size=$fsblksz >> $seqres.full 2>&1
> >  _scratch_mount
> >  
> > diff --git a/tests/xfs/432 b/tests/xfs/432
> > index 86012f0b..cd6367e2 100755
> > --- a/tests/xfs/432
> > +++ b/tests/xfs/432
> > @@ -49,7 +49,8 @@ echo "Format and mount"
> >  # block.  8187 hashes/dablk / 248 dirents/dirblock = ~33 dirblocks per
> >  # dablock.  33 dirblocks * 64k mean that we can expand a directory by
> >  # 2112k before we have to allocate another da btree block.
> > -_scratch_mkfs -b size=1k -n size=64k > "$seqres.full" 2>&1
> > +physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> > +_scratch_mkfs -b size=${physical:-1k} -n size=64k > "$seqres.full" 2>&1
> 
> This test formats a very specific geometry because it needs precise
> calculations to generate a directory with 1000 consecutively mapped
> blocks.  Does it still do that if the blocksize isn't 1k?
> 

yes, agree its geometric specific. But with above change test exits as
not run, instead of failure. Reason being unable to create >1000 data
block extents.
Yes, you are right about needing precise calculation to generate
that 1000 data block. My knowledge on file system is limited at present.
Does it makes sense to put those tests which run with 512 bytes
assumption to not_run state, instead of fail for 4096 block size
devices, as a temporary fix ? or should I just simply report them so
that persons with fs expertise fix it ?

> >  _scratch_mount >> "$seqres.full" 2>&1
> >  
> >  metadump_file="$TEST_DIR/meta-$seq"
> > diff --git a/tests/xfs/516 b/tests/xfs/516
> > index 9e1b9931..b9d4f0c9 100755
> > --- a/tests/xfs/516
> > +++ b/tests/xfs/516
> > @@ -84,7 +84,8 @@ test_su_opts()
> >  	local mounted=0
> >  
> >  	echo "Format with 256k stripe unit; 4x stripe width" >> $seqres.full
> > -	_scratch_mkfs -b size=1k -d su=256k,sw=4 >> $seqres.full 2>&1
> > +	physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> > +	_scratch_mkfs -b size=${physical:-1k} -d su=256k,sw=4 >> $seqres.full 2>&1

> This is a test of sunit/swidth.  Do you need to scale those up as well?
>

Agreed, they should be scaled.
> --D
> 
> >  
> >  	__test_mount_opts "$@"
> >  }
> > 
> > base-commit: 2ea74ba4e70b546279896e2a733c8c7f4b206193
> > -- 
> > 2.25.1
> > 
>

--
Nitesh Shetty

------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_df6bb_
Content-Type: text/plain; charset="utf-8"


------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_df6bb_--

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCB3C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 08:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiCVIqM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 04:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiCVIqK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 04:46:10 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F1E5591
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 01:44:43 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220322084441epoutp03c0f86441f98b02733ef3d9002010ba4b~ep3-kVjJh0874508745epoutp03D
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 08:44:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220322084441epoutp03c0f86441f98b02733ef3d9002010ba4b~ep3-kVjJh0874508745epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647938681;
        bh=oVenM03lbnVhLclbYTPml6ICoWqcNL9z4DeD0KWnk0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qQg38myM0/k99SpNXdk/QB601sGunN8/mIo3vDTHxq0alyfwB66hT/1//O6H15cLM
         sImny3UeJdSNOXAD7kKMpOSVae3JxaW8FFSGbBFr3jSS4sFdCGfCj+czXVBDSp5e4m
         QqYkGdkaxxq/a+88OQHwuqQDKlhF6P2pah12xOkA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220322084441epcas5p3aa5a950cb12aee56ac8cdbb55bd5ab27~ep3-N3Saj0909309093epcas5p34;
        Tue, 22 Mar 2022 08:44:41 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KN4m6032Hz4x9Q0; Tue, 22 Mar
        2022 08:44:22 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.71.05590.16C89326; Tue, 22 Mar 2022 17:44:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220322083131epcas5p381e3904d2aa049219cc70f08a2546c71~epsf2ckOm2530825308epcas5p3P;
        Tue, 22 Mar 2022 08:31:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220322083131epsmtrp12770f55034086d05fb0b5eee4b51f7d4~epsf1p7oD3167931679epsmtrp1h;
        Tue, 22 Mar 2022 08:31:31 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-4a-62398c611135
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.96.29871.36989326; Tue, 22 Mar 2022 17:31:31 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220322083130epsmtip231d4472d3eddc614bf389a837b6cac04~epsfOujOK0493004930epsmtip2N;
        Tue, 22 Mar 2022 08:31:30 +0000 (GMT)
Date:   Tue, 22 Mar 2022 13:56:29 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, nitheshshetty@gmail.com
Subject: Re: [PATCH] generic/108: use sysfs values for logical,physical
 block size in scsi_debug
Message-ID: <20220322082629.GA32722@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220321202133.GJ8200@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmum5ij2WSwfG/ChaXn/BZnG7Zy26x
        40kjowOzx85Zd9k9Nq3qZPP4vEkugDkq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMHaI+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8Ck
        QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtjwqVdrAWXRCu23HjH3MD4RLCLkZNDQsBE4tCTVaxd
        jFwcQgK7GSXuT/vPCJIQEvjEKNG9mAMi8Y1RYu7baUxdjBxgHT3v7SFq9jJKfP1eD1HzjFFi
        6sSZrCAJFgFVif+/94PVswloS5z+zwESFhHQlDjy7RoTiM0MNKZ73XGwcmGBJIl1n/rAbF4B
        XYk/H/8wQdiCEidnPmEBsTmB4n+nQsRFBZQlDmw7zgSyV0LgFLtE86pHLBDfuEhMedbDBGEL
        S7w6voUdwpaSeNnfxg7R0M0o8ePMfajuGYwSzROa2SCq7CUu7vkLdV6mxKQJbVBTZSWmnloH
        FeeT6P39BGoDr8SOeTC2ssSa9Qug5khKXPveCGV7SGzasZMZEkQbGSUm7XrHNIFRfhaS92Yh
        2Qdh60gs2P2JbRYw9JgFpCWW/+OAMDUl1u/SX8DIuopRMrWgODc9tdi0wDgvtRwe4cn5uZsY
        wclQy3sH46MHH/QOMTJxMB5ilOBgVhLhXfzBPEmINyWxsiq1KD++qDQntfgQoykwtiYyS4km
        5wPTcV5JvKGJpYGJmZmZiaWxmaGSOO+p9A2JQgLpiSWp2ampBalFMH1MHJxSDUze/ytXrQoU
        c576peq8usGv7d86Fc5VyAoI1Bf4rWf+0ubYWWrdG/V/npgIk/JSC+XbwoIRosc/Ptu0+vb7
        sJ2dm8vV647d8XiU2HKlpjYz63rnetHKsMd73qlWNqxl6KmWWZ7kJTk3yzi7TDJSZ+NU49uN
        BzYtKZiZd8+BSW2T5KRzt9ev2LR0k736ki+mu1w3mnJnpOXysXuuurl9xumtASbdOTZrxL10
        Td8sdvzNGGb0bQH7ZZOzBS+zE551WoSnhntUSZR/WfY3f/f+4KZ5L7/v/BDXvY4pKGzWShYG
        C90IprfTGuaLlTb+7WDNTrkTLhu/LM/BJbSuIvTqmsN9MhxnDK8X3FVWlVfXV2Ipzkg01GIu
        Kk4EAISk5QYPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSvG5yp2WSQU+HiMXlJ3wWp1v2slvs
        eNLI6MDssXPWXXaPTas62Tw+b5ILYI7isklJzcksSy3St0vgylg46RlrQZ9wxeaDZ9kbGHfx
        dzFycEgImEj0vLfvYuTiEBLYzSgxs/kFWxcjJ1BcUmLZ3yPMELawxMp/z9khip4wSpzpXswI
        kmARUJX4/3s/E8ggNgFtidP/OUDCIgKaEke+XWMCsZmB5nevO84KYgsLJElc+XcJzOYV0JX4
        8/EPE8TMjYwSLYvnM0IkBCVOznzCAtGsJXHj30uw+cwC0hLL/4HN5wTq/Tv1D9h8UQFliQPb
        jjNNYBSchaR7FpLuWQjdCxiZVzFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBIewluYO
        xu2rPugdYmTiYDzEKMHBrCTCu/iDeZIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNIT
        S1KzU1MLUotgskwcnFINTKezOOcpP10ta3D9uurGpvYPsgckZi/4eaCp19tsevCBbR3sqX93
        Ctz751z4RDhn2VzvJysXK5WsqlYMnNXveuNVb4eLavfWLwuqn1hW3+t7LnfiF/extzff/Nuy
        KXJbTuncl67C9auDnmTynJGZd7l99uX7f1lL+th39u70mZiiwxPf99kmzDYohEMq6nNX9s/f
        5hNdpyfcim5c1XTdbP3GuKnh9pscosuUFLr6VZblfpP8lP6CS81me8qloqY7pdPyU7KcHT6L
        C23pU7v/e/+B02wHC+bUvsxk90t+rpyam3Z/O+9x0ZcHZHxrtGOtuH1rjU4qLA6LyZlyTU5z
        ijHX1O0iDb0LZzHKz5nTocRSnJFoqMVcVJwIAKKJXmfQAgAA
X-CMS-MailID: 20220322083131epcas5p381e3904d2aa049219cc70f08a2546c71
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_139579_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd
References: <CGME20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd@epcas5p3.samsung.com>
        <20220301212947.28660-1-nj.shetty@samsung.com>
        <20220321202133.GJ8200@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_139579_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

 Mon, Mar 21, 2022 at 01:21:33PM -0700, Darrick J. Wong wrote:
> On Wed, Mar 02, 2022 at 02:59:47AM +0530, Nitesh Shetty wrote:
> > scsi_debug device used for test, is created with assumption of 512 bytes
> > logical and physical block size.
> > This causes error in lvcreate step, when SCRATCH_DEV device lba is not
> > 512 bytes. This can be solved by reading block size from sysfs of device.
> > If sysfs is missing fallback to 512 bytes as default.
> > 
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > ---
> >  tests/generic/108 | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/108 b/tests/generic/108
> > index ad43269f..db0e9bd0 100755
> > --- a/tests/generic/108
> > +++ b/tests/generic/108
> > @@ -42,8 +42,11 @@ _require_non_zoned_device $SCRATCH_DEV
> >  lvname=lv_$seq
> >  vgname=vg_$seq
> >  
> > +physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> > +logical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/logical_block_size)
> 
> This causes a regression if $SCRATCH_DEV is not a raw block device:
> 
Acked, I was testing for NVMe device, missed out sda sysfs.
Let me see, if I can use other sysfs/utility to get block size of device.

Also I see many 4k LBA tests failing mainly because of setup failure in
format command. This is not actually test failure, rather setup failure.
So what do you suggest for those type of tests?
Should I put them in not run status or just report to community so that
person with relevant expertise can add a fix?

--Nitesh Shetty


> # SCRATCH_DEV=/dev/sda4 ./check generic/108
> ...
> --- generic/108.out
> +++ generic/108.out.bad
> @@ -1,2 +1,4 @@
>  QA output created by 108
> +cat: /sys/block/sda4/queue/physical_block_size: No such file or directory
> +cat: /sys/block/sda4/queue/logical_block_size: No such file or directory
>  fsync: Input/output error
> 
> --D
> 
> > +
> >  # _get_scsi_debug_dev returns a scsi debug device with 128M in size by default
> > -SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 300`
> > +SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 300`
> >  test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
> >  echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
> >  
> > 
> > base-commit: 2ea74ba4e70b546279896e2a733c8c7f4b206193
> > -- 
> > 2.25.1
> > 
> 

------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_139579_
Content-Type: text/plain; charset="utf-8"


------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_139579_--

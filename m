Return-Path: <SRS0=OTwx=EC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CC1C388F9
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Oct 2020 16:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410EB21D41
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Oct 2020 16:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zy/+VtQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1810153AbgJ0QeJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:34:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60362 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1810149AbgJ0QeJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Oct 2020 12:34:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RGKjS6011765;
        Tue, 27 Oct 2020 16:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/7hE3wfbsc5rZ9Kououx/0MPy9ZO3d/q5BE7+wiABRs=;
 b=zy/+VtQdvzmD2gwga+nPFWJEOSOQNj1coo7ZQ5CihTN58Edb3mrTdbx+0gNeL9mpo1ao
 mt+dkKrZ+xMqmqtU3DDH4JrPyhIZp86FSVEY34eI6sW8qfDJPf4i3m8VXgEBOXxgA12d
 jE8eDl4PGNXe7Pvki+EFAAtf5Y5gNZsiRMgUKTIpxinTiCjGaU+p7u6awSIV+oMSj/2K
 TiCgTsXOXjwkriMov9bU6DUbnuWE80Vm0XBVh8u3Fj+eVggind9StDMLQ95H3ys0sUqz
 gFov9DAnr3Z3NcFB8MsxmA4Zhbezu2qRlgtMjCdEeW/8gjLCnHbwZqxLOPJpGEv4/7gr sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34dgm40qf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 16:34:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RGK5u0019978;
        Tue, 27 Oct 2020 16:34:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34cx5xbj9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 16:34:06 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09RGY5aF019877;
        Tue, 27 Oct 2020 16:34:05 GMT
Received: from localhost (/10.159.253.130)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 09:34:05 -0700
Date:   Tue, 27 Oct 2020 09:34:04 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/repair: filter unknown block state properly
Message-ID: <20201027163404.GF9830@magnolia>
References: <20201027042652.840821-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027042652.840821-1-zlang@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=1 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270099
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 27, 2020 at 12:26:52PM +0800, Zorro Lang wrote:
> xfsprogs 32e11be9 ("xfs_repair: complain about extents in unknown
> state") changed the xfs_repair output format as below:
> 
>   - _("unknown block state, ag %d, block %d\n"),
>   -         i, j);
>   + _("unknown block state, ag %d, blocks %u-%u\n"),
>   +         i, j, j + blen - 1);
> 
> It replaces "block" with "blocks". That cause xfs/030 fails. So use
> proper regex to filter the 'old' and 'new' output format both.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Aha, I had a patch to do exactly this sitting in my xfstests tree that I
never sent out.

Egad, I haven't sent much of anything since 5.6.  I better get on that.

In the meantime,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  common/repair | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/repair b/common/repair
> index 6668dd51..c8d16314 100644
> --- a/common/repair
> +++ b/common/repair
> @@ -88,7 +88,7 @@ s/(stripe unit) \(.*\) (and width) \(.*\)/\1 (SU) \2 (SW)/;
>  s/(superblock) (\d+)/\1 AGNO/;
>  s/(AG \#)(\d+)/\1AGNO/;
>  s/(reset bad sb for ag) (\d+)/\1 AGNO/;
> -s/(unknown block state, ag )(\d+)(, block )(\d+)/\1AGNO\3AGBNO/;
> +s/(unknown block state, ag )(\d+)(, blocks? )(\d+)/\1AGNO\3AGBNO/;
>  /^Note - quota info will be regenerated on next quota mount.$/ && next;
>  	print;'
>  }
> @@ -98,7 +98,7 @@ s/(unknown block state, ag )(\d+)(, block )(\d+)/\1AGNO\3AGBNO/;
>  # tree and fails to reconcile the metadata reverse mappings against the
>  # metadata).
>  _filter_repair_lostblocks() {
> -	_filter_repair | sed -e '/unknown block state, ag AGNO, block AGBNO/d'
> +	_filter_repair | sed -e '/unknown block state, ag AGNO, blocks* AGBNO/d'
>  }
>  
>  _filter_dd()
> -- 
> 2.25.4
> 

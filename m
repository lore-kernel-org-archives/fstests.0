Return-Path: <SRS0=/nFb=EJ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94284C2D0A3
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Nov 2020 11:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416C820731
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Nov 2020 11:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgKCL12 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 3 Nov 2020 06:27:28 -0500
Received: from mgw-02.mpynet.fi ([82.197.21.91]:48184 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbgKCL11 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 3 Nov 2020 06:27:27 -0500
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 0A3BNucT120458;
        Tue, 3 Nov 2020 13:27:21 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 34gvg0k4d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 13:27:21 +0200
Received: from [192.168.108.50] (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Nov
 2020 13:27:20 +0200
Subject: Re: [PATCH] tests/ceph: add Makefile
To:     Eric Biggers <ebiggers@kernel.org>, <fstests@vger.kernel.org>
CC:     Luis Henriques <lhenriques@suse.com>
References: <20201101171619.323800-1-ebiggers@kernel.org>
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
Message-ID: <94cc4e53-a1ef-eddb-b732-95b48bf2f3ba@tuxera.com>
Date:   Tue, 3 Nov 2020 13:27:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201101171619.323800-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=891 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030077
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 11/1/20 7:16 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> 'make install' stopped working because the tests/ceph/ directory is
> missing a Makefile.  Add it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thank you for the fix.

Reviewed-by: Vladimir Zapolskiy <vladimir@tuxera.com>
Tested-by: Vladimir Zapolskiy <vladimir@tuxera.com>

--
Best wishes,
Vladimir

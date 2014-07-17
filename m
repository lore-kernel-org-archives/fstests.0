Return-Path: <fstests-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:45860 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbaGQODa (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 17 Jul 2014 10:03:30 -0400
Message-ID: <53C7D786.1050509@oracle.com>
Date: Thu, 17 Jul 2014 22:02:46 +0800
From: Jeff Liu <jeff.liu@oracle.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/007: add project quota Q_XQUOTRM test
References: <53C73562.3010005@oracle.com> <20140717090714.GA16015@infradead.org>
In-Reply-To: <20140717090714.GA16015@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, "xfs@oss.sgi.com" <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>


On 07/17/2014 17:07 PM, Christoph Hellwig wrote:
> On Thu, Jul 17, 2014 at 10:30:58AM +0800, Jeff Liu wrote:
>> From: Jie Liu <jeff.liu@oracle.com>
>>
>> Add test for project quota Q_XQUOTRM operations, this patch also
>> update the golden output file to match the new output.
> 
> Changing the test to require crc filesystems seems like a bad idea.
> 
> I'd suggest to simply do two passes instead: the first one unchanged,
> and the second one testing project instead of group quotas.

Sounds reasonable to me, will post an updated version soon.

Cheers,
-Jeff

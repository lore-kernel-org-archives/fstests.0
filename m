Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23252C3261
	for <fstests@vger.kernel.org>; Mon, 22 Dec 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766422765; cv=none; b=CCueN1iiKsoMJW2n6Shwng3f5vT+ZigKjqfVZ1m1aNRrj8Il2BliAji4FoXx1CN/Wx97+rQ81k7nxG5m6MWdt9oo0sjdVDMZCqdl7pK5R5BYhiheKwC2MxOJG5X0qzbtSil0eY6doAlIp39hG3LOH/PSBin5NLeZu5sa1bybNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766422765; c=relaxed/simple;
	bh=OFDeUzG6MLkHNIXwKLfhYprqf1Ozr8m+YEntm2Rt2oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klPxlMLwRssxFzuECLxNQOduIluWiI7lAugDvxYyTZYMo50Obq7tso8K1xuwWNEElwoEyRr4i7NjPx33SGVuUv4HpMSfaqGuOdybmGAZMfGbcWUADD5mnNDVHHRdWmP6DefV50wC4lPx/aZZRjw8ChlLfnb46Z1y6bwDtn5IzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L7atnyd5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L7atnyd5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM7sTup024275;
	Mon, 22 Dec 2025 16:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KqfsXa3485kGVvA3337ymOaKqkjH20
	3z0Xh7ZEQ4ZI4=; b=L7atnyd55AcDT46CCWMlgQd+3h86jd4qjZFT5u8lzUO922
	vwNTC9dS7xQfkSyNCYsFrrLGCeXzzEQ7zTGz7L9Hwzpn25qFQ4n300m62NC+06LB
	5c1PZ3BKhgDvaaXWmZNDG+YVxuwOgBWvnoyxAny2EPo6fbkNVs8QlLCY6ArDVYzn
	Zg1vksoSJYqoRnblm+AXhqgZ7kSRl/nSBgmvL/lXWtoAwyyeEA/MCz0APrOlhJgD
	+qMy4koKESpncJEvtq7E+9vFXFdey19iAxWHxEch+vsRrFl1g1iQ6u1ZKi0bxri/
	xhJI3ahKV9oixk62NehuK3Br9YXWLdIPhIUWX8VA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5h7hs8ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 16:59:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMFip4k030183;
	Mon, 22 Dec 2025 16:59:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b66gxqa9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 16:59:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BMGxCS727394336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 16:59:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E89F820043;
	Mon, 22 Dec 2025 16:59:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1CB620040;
	Mon, 22 Dec 2025 16:59:10 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.23.61])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Dec 2025 16:59:10 +0000 (GMT)
Date: Mon, 22 Dec 2025 22:29:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] generic/108: fix test hand upon failure to create LV
Message-ID: <aUl43EdYJK-Tb2Y0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <79202ac8855a232c678bb9bddabda8c1866bc400.1766387606.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79202ac8855a232c678bb9bddabda8c1866bc400.1766387606.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE1NCBTYWx0ZWRfXztZ5tVjjtG4l
 Xn9YAuIezyxBhk5KDEHOeWsw67QRRxLTUC+SdmtftELA0CVSsy1MXrBSMemmioykLmoYVFdHJUR
 +sMe8vOHFB+mYcvj5dpP0EEb2HM2q0v0B9aW1hsr1qiCo2vwnfASKsLv3sMBSRuzqyeYzZTfIH2
 k2NtultBAEXvCqqMT0xBc6fpWUPKO8L6Bf79B09ggdYebfpt/Y+bNydPTzQijwxRYedc/+CiElO
 fl6t99I+rpCeCCnnWGjmVR92PV8bU4Dh4GWAwV8L4+QECOAdDDJ0JeTun8m/pyw4dx0j4VAEwTA
 O2FqJU6NDxlGBkloxHDcTd0YLnqS51JiUaRJ6UIErxDHY/bZggCI84KeTeykzKoLnQqk+mqVix8
 LcSz0AaLPHW2+R+g+v5WYd+QZqmcTfnyj5DReEiq4AldFgtMhkgZwrQNPlXuAljXSMzwGwINXaL
 yv7pNDQleMnNRLt+VVA==
X-Authority-Analysis: v=2.4 cv=Ba3VE7t2 c=1 sm=1 tr=0 ts=694978e7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=f3wBJKyez26hFQYQ56kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 0IpQu-uPMCnQ9Z6N6VNUEPh7EEVXQdQA
X-Proofpoint-GUID: 0IpQu-uPMCnQ9Z6N6VNUEPh7EEVXQdQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512220154

On Mon, Dec 22, 2025 at 12:44:09PM +0530, Ojaswin Mujoo wrote:
> In case the lvcreate operation fails, we don't catch the error and
> proceed as usual. The test then tries to wait for the LV to come up
> but it never does, causing a hang.
> 
> Fix this by catching any errors while creating the LV.
> 
> Context for completeness:
> 
> This was noticed when we accidentally used CONFIG_SCSI_DEBUG=y instead
> of =m, causing it to create an 8MB SCSI debug device. This led to the
> lvcreate operation to fail with:
> 
>   Insufficient suitable allocatable extents for logical volume lv_108: 68 more required
> 
> However the test never caught this resulting in a hang.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Missed to add (hope this gets auto picked up during merge :) ):

Reported-by: Disha Goel <disgoel@linux.ibm.com>

Regards,
ojaswin

> ---
>  tests/generic/108 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/108 b/tests/generic/108
> index 4f86ec94..308afe20 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -60,7 +60,7 @@ $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
>  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>  # (like 2.02.95 in RHEL6) don't support --yes option
>  yes | $LVM_PROG lvcreate -i 2 -I 4m -L ${lvsize}m -n $lvname $vgname \
> -	>>$seqres.full 2>&1
> +	>>$seqres.full 2>&1 || _notrun "Failed to create LVM lv"
>  _udev_wait /dev/mapper/$vgname-$lvname
>  
>  # _mkfs_dev exits the test on failure, this makes sure test lv is created by
> -- 
> 2.51.0
> 

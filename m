Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9462F0C46;
	Thu, 21 Aug 2025 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774341; cv=none; b=Pnfh9gik1OyS2DHWsp84iOBjsULFuNxWGNHPeqKo4DMc2dhM6SdpKowT/6zsJTaPho062w+07yRiNHd4zc3TklKgR8RY2D17cNATHZQ0XWCgiiq9rZtOGCCormy6dEDZKZxjjL5QI66dfQu1By5x6NT7duNkdL8qBcd7cUZKgA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774341; c=relaxed/simple;
	bh=H5PAtIsi+ZryOcW08UFiqAu8tRNSAroiUJuaTRQbX8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyEFjft0lTgzLCLRuvLRcaXOd+Jk1oyYM2iRYGSR/VWb16JrnDazX83f9oIQWZq92OGzZke8j805RxT2jR4T9DXKfFMeRQnYPYA5KNZqlg30iOi3tLqu8x4nUNNTq4jPMm9sHGPbNc7QqKxfTK5Bept3bHJ7X+dSAjoO6NkjrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l6Y4Y3ZE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l6Y4Y3ZE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6GFXk011680;
	Thu, 21 Aug 2025 11:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9KOjod
	VKSG86MJB+wuj94P7nwqDNdceJnIe5s7cEhyU=; b=l6Y4Y3ZEmt7VtZ6e84XAKH
	iNy9KE/wT2RTTO+m1/c+hX85wPJg6MjwYtjjVrZI7MN0pKbrYkbBYONHHZE0YXtj
	d/pDfUQeMmSB0mEtSMaXQuYA3eYgXDQXNeVMuC09swZOmCYB2UC9inxKCiZksEH0
	s/t/86bYr9xK2nueLp0/uxPGO8Yp+oYlmteG6FLWc5c1L23BiAh72mLg1CWaiMqw
	V3mCYyEd91AkHxUgFVzKpkgex1QYLmodE0DXjGeEgmCCGOsQBnf+zlWjHT9VK2k6
	e6m9As9kqMW/VM80Tk5Y7vuB8HpLxjT4BsHIRfVltb5Cz2Gp+h+ZNoLTm3zl88nw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vr4hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:05:33 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57LB18J1001225;
	Thu, 21 Aug 2025 11:05:33 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vr4hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:05:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAndiC031845;
	Thu, 21 Aug 2025 11:05:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5y8048-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:05:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LB5Uht48955696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 11:05:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1ADB20040;
	Thu, 21 Aug 2025 11:05:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 914DB20043;
	Thu, 21 Aug 2025 11:05:29 +0000 (GMT)
Received: from [9.109.217.148] (unknown [9.109.217.148])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 11:05:29 +0000 (GMT)
Message-ID: <7f52f3ad-ad01-4337-be3a-eb281e319b24@linux.ibm.com>
Date: Thu, 21 Aug 2025 16:35:28 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/365: Fix false failure when mapping ends with
 free space
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        linux-kernel@vger.kernel.org
References: <cc80fdb62151d677809f2eb36eadebd3720c8701.1754385487.git.ojaswin@linux.ibm.com>
Content-Language: en-GB
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <cc80fdb62151d677809f2eb36eadebd3720c8701.1754385487.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX5YHaHWjf7ttj
 KCWZMD1oucTornXtyEezwStLQc5VjvLvW4baDFPipINWP6Q67tM+MrI553DoI8M20Lcfe/b+y8t
 MqVl5qQq5FgNArzWtPzcc0JNPUxi3p7TPOQPCLtrmx6dON8ONmS0VhySpBgZ5i1wTITqtcL62zv
 ZGPLHperLlH+LkNYzpxRYTNtJlR78ClYDSipzdP5P9TWYbuKfsnwFBtJlp/rNVdgoAXEPRohsGM
 NyRF+8g0hD13XeReaHFPYxIzA8abMWWdr45kIw/S4SwzJngr518H2OPN3rhU/QYr5hotU9hVzEU
 xLjnwJhYqsay53z/oOGHI619UBDRLSkF1Oe6oH05YG850t/R83mgi07NJY7da4JTJwKRqtn/0wy
 qfqWY25I7g4nN/Bsmey5c329FMqJhQ==
X-Proofpoint-ORIG-GUID: UvwHFhqaKqyWf84aqA3YFo-PuMomyVmf
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a6fd7d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=KIs-IOsx-tpsIMvQhSAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LLkuNLn4ZpBLpG79TeDgHsdLiQbsBOkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

On 05/08/25 2:55 pm, Ojaswin Mujoo wrote:
> If we have a small FS where the first free space mapping is also the
> last mapping of the FS, then the following sub-test fails:
> 
>    echo "test whatever came after freesp"
>    $XFS_IO_PROG -c "fsmap -d $((freesp_end + 2)) $((freesp_end + 3))" $SCRATCH_MNT
> 
> since there is nothing after the freespace. Fix this by punching a 1M
> hole in a 3M file to ensure that the first free space is always
> surrounded by allocated blocks.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

I tested the patch on Power, and it resolves the test failures with a 
64k block size.

Tested-by: Disha Goel <disgoel@linux.ibm.com>

SECTION       -- ext4_64k
RECREATING    -- ext4 on /dev/loop0
FSTYP         -- ext4
PLATFORM      -- Linux/ppc64le localhost 6.17.0-rc2-00060-g068a56e56fa8 
#2 SMP Thu Aug 21 16:28:18 IST 2025
MKFS_OPTIONS  -- -F -b 65536 /dev/loop1
MOUNT_OPTIONS -- -o block_validity /dev/loop1 /mnt/scratch

generic/365 1s ...  1s
Ran: generic/365
Passed all 1 tests

> ---
>   tests/generic/365 | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/365 b/tests/generic/365
> index 36cb2530..bbadae71 100755
> --- a/tests/generic/365
> +++ b/tests/generic/365
> @@ -32,6 +32,10 @@ if ((blksz < 2048)); then
>   	_notrun "test requires at least 4 bblocks per fsblock"
>   fi
>   
> +# This makes sure there is free space surrounded by allocated blocks, which
> +# is needed for some sub tests.
> +$XFS_IO_PROG -fc 'falloc 0 3M' -c 'fpunch 1M 1M' -c 'fsync' $SCRATCH_MNT/f
> +
>   $XFS_IO_PROG -c 'fsmap' $SCRATCH_MNT >> $seqres.full
>   
>   find_freesp() {


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8566229B1E
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432138; cv=none; b=lh5NbhNLIeNOypgWe9bq125LR/QPLiSndWcUIHvCTNDrU+dYXQSpGtX+Dhr7yz364mzLNLNhOhVJv8TUmlovQqLxCk66sUTQuYQBJClle8DtO6DGYHCcX82j9xpmxjTr8/JzVm0Jyz/f58D2swe9ohebeSJaVO6aDSfwLhSvyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432138; c=relaxed/simple;
	bh=NOJnza16dUBGj+Wn2TfPklEPsXapNm8OvfkOHuTojpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC2AFP0QCNGQaGe8P+004cMB/4uf4hea9T3l0vF8a9IciY6antk30nWM1mrQnw9kBec3J4GKzK9G1o2XKTYLpRhBjjrOeQrKoZZHwJoKZ3P2CpYiT5WAxp4ltVGbXinHKxwIP1Z4B7DiVPpG1lTYWwqs5Zxsah4Wn1wDAHkQPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PXLCKDBU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PXLCKDBU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K82XaA029567;
	Fri, 20 Jun 2025 15:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ghroivC9+r6REFzQGU0zxaAW2s043t
	HWl+5tgerWjNU=; b=PXLCKDBUcc0rty8NQiY38UU5dKLwwGhd0lrHLfSIwklRsc
	sPSwbzmn4Th/JE0Sop1qKuzq44DP7GydgfGEtiVDV6YVrh5iKjRL38OnI5JSzmEo
	FsH0inZEf4t6xI+xAFu13mx186kzfOvCQ/+m9JWld78AZJMbS6wc08/o05M7GWuS
	xHlP34rcpaa/AFOpevwNUY4jBYclEMcb6EItulYvRq7fqudu+8Y7jdLl8U7M44iQ
	WQKLyrOIvcqFjtaKbLsZR/A/66w0Rdkh2GSFy5pPL2Uvxey6EIdgOTe5ZZctk6ld
	6WpUko1aHX+BWCP2LT3lJKeXrp5sWw+zsLuAIC1Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ku4h83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 15:08:49 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55KF8nLK004995;
	Fri, 20 Jun 2025 15:08:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ku4h7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 15:08:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55KCvwn6027509;
	Fri, 20 Jun 2025 15:08:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479kt0bvgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 15:08:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55KF8kwE18678052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 15:08:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CC0220043;
	Fri, 20 Jun 2025 15:08:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F50320040;
	Fri, 20 Jun 2025 15:08:43 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.222.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Jun 2025 15:08:43 +0000 (GMT)
Date: Fri, 20 Jun 2025 20:38:40 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 09/12] ext4/061: Atomic writes stress test for bigalloc
 using fio crc verifier
Message-ID: <aFV5RCqvEylNTOVt@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <1fb9171017c601c3a1e1da1581d5da41746ca813.1749629233.git.ojaswin@linux.ibm.com>
 <20250619074351.6tyynxkbzkzjmjub@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619074351.6tyynxkbzkzjmjub@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3qT7uvxBoxTk41qCiYMfn65mLhqtGMAd
X-Proofpoint-ORIG-GUID: cu8G-GYhlQNgOP7pIZmGcuXB-M19Rnmj
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=68557982 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=bV4E3VAVvxcHfiLlBZMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEwNSBTYWx0ZWRfXzvBB8kv11lei AqCfCST681HZwEO44t3d/g0A+P1i5I7stN51gNsUy9NW2peidEq3gN+OGFnvblqpJ+A79OZzDzJ XiXzeivfN+qizyXEbSyhsc7W5QRhUWsj9kEqen5bYC44BUeRJpffYr0fcimZ0+edAr2OX3usxtI
 Ph++alKPIx4IeaRem7cTr+Lsp5Hf7izhzJbPT5Gxmv7cvG2inotP+XfsINS94nq1QUHw/wNznwL ge+9hoaDYp+gKtiHBGOdX8uEj0ooaviXVPnzFXFykpYTCBAnjW0QGOne5aNXLqA+3t7eqEkr40Y enOTZxixzvZsgNsZJSKwlACkBGhgHSIfU7/J9umoyxLXUDTZuYgcBWqsp3SHrLK8aGQKbYAxm1P
 4/VU6mGqZmbdNkOjecAa0biZpugN4SE2L8uvSrQOQcx0Kv9L7RhXRJUGUjulT0cRSAgpv8Yp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200105

On Thu, Jun 19, 2025 at 03:43:51PM +0800, Zorro Lang wrote:
> On Wed, Jun 11, 2025 at 03:04:52PM +0530, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > We brute force all possible blocksize & clustersize combinations on
> > a bigalloc filesystem for stressing atomic write using fio data crc
> > verifier. We run nproc * $LOAD_FACTOR threads in parallel writing to
> > a single $SCRATCH_MNT/test-file. With atomic writes this test ensures
> > that we never see the mix of data contents from different threads on
> > a given bsrange.
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/ext4/061     | 107 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/061.out |   2 +
> >  2 files changed, 109 insertions(+)
> >  create mode 100755 tests/ext4/061
> >  create mode 100644 tests/ext4/061.out
> > 

<snip>

> > +function max()
> > +{
> > +	if (( $1 > $2 )); then
> > +		echo "$1"
> > +	else
> > +		echo "$2"
> > +	fi
> > +}
> > +
> > +function min()
> > +{
> > +	if (( $1 < $2 )); then
> > +		echo "$1"
> > +	else
> > +		echo "$2"
> > +	fi
> > +}
> 
> I've seen these two functions many times, please make them to be common helpers.

Yes I will do this in v2.

> 
> > +
> > +FS_MAX_CLUSTER_SIZE=$((128*1024))
> > +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> > +SIZE=$((100*1024*1024))
> > +fiobsize=4096
> > +
> > +# Calculate fsblocksize and FS_MAX_CLUSTER_SIZE as per bdev atomic write units.
> > +bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> > +bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> > +fsblocksize=$(max 4096 "$bdev_awu_min")
> > +FS_MAX_CLUSTER_SIZE=$(min "$FS_MAX_CLUSTER_SIZE" "$bdev_awu_max")
> > +
> > +function create_fio_config()
> > +{
> > +cat >$fio_config <<EOF
> > +	[aio-dio-aw-verify]
> > +	direct=1
> > +	ioengine=libaio
> 
> _require_aiodio

Got it, thanks
> 
> > +	rw=randwrite
> > +	bs=$fiobsize
> > +	fallocate=native
> > +	filename=$SCRATCH_MNT/test-file
> > +	size=$SIZE
> > +	iodepth=$FIO_LOAD
> > +	numjobs=$FIO_LOAD
> > +	group_reporting=1
> > +	verify_state_save=0
> > +	verify=crc32c
> > +	verify_fatal=1
> > +	verify_dump=0
> > +	verify_backlog=1024
> > +	verify_async=4
> > +	verify_write_sequence=0
> > +	atomic=1
> > +EOF
> > +}
> > +
> > +# Let's create a sample fio config to check whether fio supports all options.
> > +fio_config=$tmp.fio
> > +create_fio_config
> > +_require_fio $fio_config
> > +
> > +for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
> > +	for ((fsclustersize=$fsblocksize; fsclustersize <= $FS_MAX_CLUSTER_SIZE; fsclustersize = $fsclustersize << 1)); do
> > +		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
> 
> Wow, 3 for loops...

Yes :) We want to test all the combinations. Since the IO is less, it
usually finishes within a reasonable time (~5 mins)

> 
> > +			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
> > +			_scratch_mkfs_ext4 "$MKFS_OPTIONS" >> $seqres.full 2>&1 || continue
> 
> MKFS_OPTIONS is used in _scratch_mkfs_ext4 by default, you don't need to use it as
> an argument.
> 
> Or do you want to do:
> 
> _scratch_mkfs_ext4 "-O bigalloc -b $fsblocksize -C $fsclustersize" ?

Yes we want to explicitly run these options so various block and cluster
sizes get tested irrespective of what the user passes in MKFS_OPTIONS.

However, looking at _scratch_mkfs_ext4() > _scratch_do_mkfs() we seem
to try mkfs.ext4 $MKFS_OPTIONS $extra_mkfs_options first and if that fails we 
anyways try mkfs $extra_mkfs_options.

That being said, I'm a bit unsure whether something like:

mkfs.ext4 $MKFS_OPTIONS -O bigalloc -b $fsblocksize -C $fsclustersize

would produce reliable results always so:

		MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
		_scratch_mkfs_ext4

seems better approach. Thoughts?

> 
> > +			if _try_scratch_mount >> $seqres.full 2>&1; then
> > +				touch $SCRATCH_MNT/f1
> > +				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
> > +				fio_config=$tmp.fio
> 
> Do you change the "$tmp"? If not, you don't need to set fio_config=$tmp.fio
> everytime, you've set fio_config above this for loop.
> 
> > +				fio_out=$tmp.fio.out
> 
> If you don't change "$tmp", you can set fio_out once, before the
> for loop running.
> 
> > +				create_fio_config
> > +				_require_fio $fio_config
> 
> I think only $fiobsize will be changed in $fio_config at here, so you're trying
> to check "bs=$fiobsize"? If so, that doesn't make sense, due to _require_fio accepts
> any "bs" number, except bs <= 0. So you don't need to call _require_fio
> at here everytime, especially you've called it before the loop running.
> 

Makes sense, I'll clean this up.

Thanks,
ojaswin

> Thanks,
> Zorro
> 
> > +				cat $fio_config >> $seqres.full
> > +				$FIO_PROG $fio_config --output=$fio_out
> > +				ret=$?
> > +				cat $fio_out >> $seqres.full
> > +				_scratch_unmount
> > +				[[ $ret -eq 0 ]] || break;
> > +			fi
> > +		done
> > +	done
> > +done
> > +
> > +# success, all done
> > +echo Silence is golden
> > +status=0
> > +exit
> > diff --git a/tests/ext4/061.out b/tests/ext4/061.out
> > new file mode 100644
> > index 00000000..273be9e0
> > --- /dev/null
> > +++ b/tests/ext4/061.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 061
> > +Silence is golden
> > -- 
> > 2.49.0
> > 
> > 
> 

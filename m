Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757778F4A
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417891; cv=none; b=pmMMM4KdjPj4fHX/Q9GSSjQdsqPqm9g6I8mragW+k7sM1i9aPjocQ4jyPWTtmVZGL3ZTqsDpoE9FqyXYuRWGY8jRGH1QuXjHVo4qO6e5nb+fCfmKre58QS7dRhX4T59fP4/mSaGu8psW8KE0F4Z5CeAXoHuGFsa0fSRG37MdLuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417891; c=relaxed/simple;
	bh=KlHGrdJB9mNfAXuVaziLjd2gAeVY7vntYOAzURClHXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crMGwJuXzLTRQJnDF6xWll2B8MbBGfG89JBGaXpMn22Ph2lVCMhdHu3SYC3xgvtOlsEplvNxEiUNbKVnmmGHvw0n7P3ZcfYUGromRcwE53YYAX1657pz2jvQY3XhPar/2qL1ctE0jA8FGHFd9uA2k9O/nf+5KD0r8+Qgu39DsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SLek41xx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SLek41xx"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K7UuhV029634;
	Fri, 20 Jun 2025 11:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ARwvS9Nzl5ZV+AbcIXjIOZn0NZUc33
	Yk5KIZff3mz1U=; b=SLek41xxPfwOy9vC3wAXaf+Zxj8AbUi0Xh2AO1le2oVrQL
	mbYCfDE/D0ZvNOPGMztw2vV6timtIJ3TTMcycbR25vhiBRM4Rq95bgnUrsh1sGW8
	NspInPC64kq7aeb67R+ztQYhv2aIL3wni2ULtTchbXbxWvPqvKzvIQ8z2oeAn3Qm
	xVUFotcPKlFYIGp5EgNLKQyBbPZWjDnJ3tOJVvT9kW3eNuezmqtGvMeuwbBZThB+
	/XeJDwUMPTdMAbyvey7V9IjfgjvN4CeQjNK6n8uZkg3Iyrwp+qoZEoocFEwerXu7
	5wD9hRhelGrgVNE/SY9jzSdjSMMQcCkXcEeo2NFQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ku3a6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 11:11:22 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55KB65W3017652;
	Fri, 20 Jun 2025 11:11:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ku3a6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 11:11:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55K8x3WE011236;
	Fri, 20 Jun 2025 11:11:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 479kdtu1a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 11:11:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55KBBJeC52429164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 11:11:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 677C02004B;
	Fri, 20 Jun 2025 11:11:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 054F820043;
	Fri, 20 Jun 2025 11:11:18 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.221.59])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Jun 2025 11:11:17 +0000 (GMT)
Date: Fri, 20 Jun 2025 16:41:14 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 08/12] generic/772: Add sudden shutdown tests for multi
 block atomic writes
Message-ID: <aFVB0oA0WNn8sr9E@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <fe30e64171982a664579d11c1277b2a033b952ab.1749629233.git.ojaswin@linux.ibm.com>
 <20250619071506.4y7z2milesbo6vsl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619071506.4y7z2milesbo6vsl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e07WWIOWmYP92AjwjvDRAZkptRDgRJDj
X-Proofpoint-ORIG-GUID: mRDgdzCfZELAhohZUtygQef1KC5ss7e6
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=685541da cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=fU6tGNsZVNQFo9tcPbsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA3OCBTYWx0ZWRfXwuubi5V91L13 Up+oom6MS311XvOQYqSzbde92FUQT2/C7kIA1Gd/DQ7pIBR2TS5y/3TkR4QzRUxZ3UoHfSElnXF uyLw2bZhBf6CxAABJ60ENayzrz/9bvi5XjwFqn+4Da0/Y7OMnRan8n3o2lDad55u51GzXzRzLWl
 HZ8s5+8gOynEiNXjTtqkeLT2k7jmYDVUhSEdGbalaB5I+a2xtTrsyMfjRrMwVj4l50Fr18C+I37 GAKOfrOyK3WoPbDQOQqw5M7aEv6UA5MPdpnaQa+sl6Hf74E+HGPAk70WyvW49wv7PF2+hhs8eyu YKZHI97IM4yGxJGI5ad2vhP+R6kSsvqC6ddMk71lj02n7I6tehVTb3lxJA2JAnCcrNbVXKooiXe
 vKZDebmMUu93NZAIJNxXXbJZvMUsmicowhrUnsk9L4kmVLR/LDnIZ/B+rZtyMJ2XJE2lQ1+X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_04,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200078

On Thu, Jun 19, 2025 at 03:15:06PM +0800, Zorro Lang wrote:
> On Wed, Jun 11, 2025 at 03:04:51PM +0530, Ojaswin Mujoo wrote:
> > +
> > +atomic_write_loop() {
> > +	local off=0
> > +	local size=$awu_max
> > +	for ((i=0; i<$((filesize / $size )); i++)); do
> > +		# Due to sudden shutdown this can produce errors so just redirect them
> > +		# to seqres.full
> > +		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
> 
> _require_xfs_io_command pwrite -A
> 
> > +		echo "Written to offset: $off" >> $tmp.aw
> > +		off=$((off + $size))
> > +	done
> > +}
> > +
> > +create_mixed_mappings() {
> > +	local file=$1
> > +	local size_bytes=$2
> > +
> > +	echo "# Filling file $file with alternate mappings till size $size_bytes" >> $seqres.full
> > +	#Fill the file with alternate written and unwritten blocks
> > +	local off=0
> > +	local operations=("W" "U")
> > +
> > +	for ((i=0; i<$((size_bytes / blksz )); i++)); do
> > +		index=$(($i % ${#operations[@]}))
> > +		map="${operations[$index]}"
> > +
> > +		case "$map" in
> > +		    "W")
> > +			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null
> > +			;;
> > +		    "U")
> > +			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
> 
> _require_xfs_io_command falloc
> 
> > +			;;
> > +		esac
> > +		off=$((off + blksz))
> > +	done
> > +
> > +	sync $file
> > +}
> > +
> > +populate_expected_data() {
> > +	# create a dummy file with expected old data for different cases
> > +	create_mixed_mappings $testfile.exp_old_mixed $awu_max
> > +	expected_data_old_mixed=$(xxd -s 0 -l $awu_max -p $testfile.exp_old_mixed)
> 
> "xxd" it's not a necessary running dependence of xfstests, please replace it with
> common/rc:_hexdump() function or other similar commands in coreutils. Or you have
> to _notrun if there's not xxd installed.

Hey Zorro, got it I'll switch to using od which is what _hexdump also
uses. Won't be using _hexdump helper though since the defaults print the
address of byte as well, which is not something I want. 

<snip>

> > +
> > +# test data integrity for file by shutting down in between atomic writes
> > +test_data_integrity() {
> > +	echo >> $seqres.full
> > +	echo "# Writing atomically to file in background" >> $seqres.full
> > +	atomic_write_loop &
> > +	awloop_pid=$!
> 
> If there's background processes in test case, please make sure it's killed in
> _cleanup(), e.g.
> 
> _cleanup()
> {
> ...
> 	[ -n "$awloop_pid" ] && kill $awloop_pid
> 	wait
> ...

Thanks for pointing this out, I'll take care of this.
> }
> 
> > +
> > +	# Wait for atleast first write to be recorded
> > +	while [ ! -f "$tmp.aw" ]; do sleep 0.2; done
> > +
> > +	echo >> $seqres.full
> > +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> > +	_scratch_shutdown
> 
> _require_scratch_shutdown
> 
> > +
> > +	kill $awloop_pid
> > +	wait $awloop_pid
> 
> 	unset awloop_pid
> 
> tell _cleanup "it's killed".
> 
> > +
> > +	last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> > +	cat $tmp.aw >> $seqres.full
> > +	echo >> $seqres.full
> > +	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
> > +
> > +	rm $tmp.aw
> > +	sleep 0.5
> > +
> > +	_scratch_cycle_mount
> > +
> > +	# we want to verify all blocks around which the shutdown happended
> > +	verify_start=$(( last_offset - (awu_max * 5)))
> > +	if [[ $verify_start < 0 ]]
> > +	then
> > +		verify_start=0
> > +	fi
> > +
> > +	verify_end=$(( last_offset + (awu_max * 5)))
> > +	if [[ "$verify_end" -gt "$filesize" ]]
> > +	then
> > +		verify_end=$filesize
> > +	fi
> > +}
> > +
> > +# test data integrity for file wiht written and unwritten mappings
> > +test_data_integrity_mixed() {
> > +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> 
> _require_xfs_io_command truncate

Will do.

> 
> > +
> > +	echo >> $seqres.full
> > +	echo "# Creating testfile with mixed mappings" >> $seqres.full
> > +	create_mixed_mappings $testfile $filesize
> > +
> > +	test_data_integrity
> > +
> > +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mixed" "$expected_data_new"
> > +
> > +	if [[ "$?" == "1" ]]
> > +	then
> > +		return 1
> > +	fi
> 
> If the return value is useful, you'd better to "return 0" clearly. Or the
> return value of this function will be unclear.
> 
> > +}
> > +
> > +# test data integrity for file with completely written mappings
> > +test_data_integrity_writ() {
> > +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> > +
> > +	echo >> $seqres.full
> > +	echo "# Creating testfile with fully written mapping" >> $seqres.full
> > +	$XFS_IO_PROG -c "pwrite -b $filesize 0 $filesize" $testfile >> $seqres.full
> > +	sync $testfile
> > +
> > +	test_data_integrity
> > +
> > +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mapped" "$expected_data_new"
> > +
> > +	if [[ "$?" == "1" ]]
> > +	then
> > +		return 1
> > +	fi
> 
> Same as above
> 
> > +}
> > +
> > +# test data integrity for file with completely unwritten mappings
> > +test_data_integrity_unwrit() {
> > +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> > +
> > +	echo >> $seqres.full
> > +	echo "# Creating testfile with fully unwritten mappings" >> $seqres.full
> > +	$XFS_IO_PROG -c "falloc 0 $filesize" $testfile >> $seqres.full
> > +	sync $testfile
> > +
> > +	test_data_integrity
> > +
> > +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
> > +
> > +	if [[ "$?" == "1" ]]
> > +	then
> > +		return 1
> > +	fi
> 
> Same
> 
> > +}
> > +
> > +# test data integrity for file with no mappings
> > +test_data_integrity_hole() {
> > +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> > +
> > +	echo >> $seqres.full
> > +	echo "# Creating testfile with no mappings" >> $seqres.full
> > +	$XFS_IO_PROG -c "truncate $filesize" $testfile >> $seqres.full
> > +	sync $testfile
> > +
> > +	test_data_integrity
> > +
> > +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
> > +
> > +	if [[ "$?" == "1" ]]
> > +	then
> > +		return 1
> > +	fi
> 
> Same
> 
> > +}
> > +
> > +test_filesize_integrity() {
> > +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> > +
> > +	echo >> $seqres.full
> > +	echo "# Performing extending atomic writes over file in background" >> $seqres.full
> > +	atomic_write_loop &
> > +	awloop_pid=$!
> 
> Please use another name, then deal with it in _cleanup, refer to
> above awloop_pid.
> 



<snip>

> > +
> > +	echo >> $seqres.full
> > +	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full
> > +	test_filesize_integrity
> > +	if [[ "$?" == "1" ]]
> > +	then
> > +		status=1
> > +		break
> 
> What are these "status=1" for? You "break" the loop run directly after setting
> status=1, then the status will be set to 0 at the end of the test.
> 
> You can output something to break the golden image (.out file). Or call _exit
> or _fail to end the test with an error output.
> 
> Thanks,
> Zorro

Ohh right, I don't even know why I didn't just _fail if the check in
verify_data_blocks fails. That will save all this stupid return value
handling logic I've added. Thanks so much for pointing this out, I'll
fix it in next iteration!

Regards,
ojaswin

Received: from cn.fujitsu.com ([59.151.112.132]:12507 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754183AbcE0GpA (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 27 May 2016 02:45:00 -0400
Message-ID: <5747ECE0.6060105@cn.fujitsu.com>
Date: Fri, 27 May 2016 14:44:48 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: question about xfs/122
References: <146424222237.6278.4174636124436241002.stgit@birch.djwong.org> <5746A64D.6080309@cn.fujitsu.com> <20160526163249.GA4595@birch.djwong.org>
In-Reply-To: <20160526163249.GA4595@birch.djwong.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


> On Thu, May 26, 2016 at 03:31:25PM +0800, Xiao Yang wrote:
>> Hi Darrick
>>
>> When i run xfstests test case xfs/122 on RHEL7.2GA with xfsprog-dev(4.5.0),
>> I always get such error about xfs/122:
>> ---------------------------------------------------------
>>   sizeof(struct xfs_extent_data_info) = 32
>>   sizeof(struct xfs_fs_eofblocks) = 128
>>   sizeof(struct xfs_icreate_log) = 28
>> -sizeof(struct xfs_refcount_key) = 4
>> -sizeof(struct xfs_refcount_rec) = 12
>> -sizeof(struct xfs_rmap_key) = 4
>> -sizeof(struct xfs_rmap_rec) = 24
>> -sizeof(struct xfs_rmapx_key) = 20
>>   sizeof(xfs_agf_t) = 224
>>   sizeof(xfs_agfl_t) = 36
>>   sizeof(xfs_agi_t) = 336
>> ---------------------------------------------------------
>>
>> This case can pass with modern xfsprogs(i.e. 4.3+ and all the new v5 stuff) as you said.
>> Could you tell me which specific version can support this case. In addition, what can be
>> done to work around this failure.
> The missing fields are for the reflink and rmap btrees.  I could say
> to just ignore it, but I don't want to establish a precedent of
> ignoring xfs/122 errors...
>
> I'm wondering if perhaps this test ought to filter out /missing/ lines
> in the test output?
>
> --D
>
Hi Darrick
When i run xfstests test case xfs/122 on RHEL7.2GA with 
xfsprog-dev(3.2.2), i will get such error abou xfs/122:
-------------------------------------------------------------------------------------------
-offsetof(xfs_sb_t, sb_agblklog) = 124
-offsetof(xfs_sb_t, sb_agblocks) = 84
-offsetof(xfs_sb_t, sb_agcount) = 88
-offsetof(xfs_sb_t, sb_bad_features2) = 204
-offsetof(xfs_sb_t, sb_blocklog) = 120
-offsetof(xfs_sb_t, sb_blocksize) = 4
-offsetof(xfs_sb_t, sb_crc) = 224
-offsetof(xfs_sb_t, sb_dblocks) = 8
-offsetof(xfs_sb_t, sb_dirblklog) = 192
-offsetof(xfs_sb_t, sb_fdblocks) = 144
-offsetof(xfs_sb_t, sb_features2) = 200
-offsetof(xfs_sb_t, sb_features_compat) = 208
-offsetof(xfs_sb_t, sb_features_incompat) = 216
-offsetof(xfs_sb_t, sb_features_log_incompat) = 220
-offsetof(xfs_sb_t, sb_features_ro_compat) = 212
-offsetof(xfs_sb_t, sb_flags) = 178
-offsetof(xfs_sb_t, sb_fname[12]) = 120
-offsetof(xfs_sb_t, sb_frextents) = 152
-offsetof(xfs_sb_t, sb_gquotino) = 168
-offsetof(xfs_sb_t, sb_icount) = 128
-offsetof(xfs_sb_t, sb_ifree) = 136
-offsetof(xfs_sb_t, sb_imax_pct) = 127
-offsetof(xfs_sb_t, sb_inoalignmt) = 180
......
-sizeof(struct xfs_acl) = 4
-sizeof(struct xfs_acl_entry) = 12
-sizeof(struct xfs_attr3_leaf_hdr) = 80
-sizeof(struct xfs_attr3_leafblock) = 88
-sizeof(struct xfs_attr3_rmt_hdr) = 56
-sizeof(struct xfs_btree_block) = 72
-sizeof(struct xfs_clone_args) = 32
-sizeof(struct xfs_da3_blkinfo) = 56
-sizeof(struct xfs_da3_intnode) = 64
......
-------------------------------------------------------------------------------------------

I think the number of structure is always changing based on different 
xfsporg-dev version.
Can we determine whether all expected structure exist in current 
enviroment or not by comparing
line number of standard output with line number of actual output? If the 
line number of actual
output is less than expeted number of structure, we trust that some 
structure is missing and set
test result to not run.

Regards,
Xiao Yang
>> Please advise. Thanks very much.
>>
>> Regards,
>> Xiao Yang
>>
>>
>>
>>
>>
>> _______________________________________________
>> xfs mailing list
>> xfs@oss.sgi.com
>> http://oss.sgi.com/mailman/listinfo/xfs
>
>




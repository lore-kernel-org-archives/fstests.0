Received: from sandeen.net ([63.231.237.45]:52898 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751504AbeCWWrg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Mar 2018 18:47:36 -0400
Subject: Re: [PATCH] xfs/444: test log replay after XFS_IOC_SWAPEXT
References: <9227d8db-faf6-5c19-239b-074c7f5cfc00@sandeen.net>
 <20180226130212.GA51394@bfoster.bfoster>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <38c23c96-0eef-bab2-5c56-566e3ef850d1@sandeen.net>
Date: Fri, 23 Mar 2018 17:47:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180226130212.GA51394@bfoster.bfoster>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 2/26/18 7:02 AM, Brian Foster wrote:
> On Fri, Feb 23, 2018 at 12:33:41PM -0600, Eric Sandeen wrote:
>> This is a mashup of xfs/042 and some of the log replay tests;
>> it checks whether the log can be replayed if we crash immediately
>> after an xfs_fsr / XFS_IOC_SWAPEXT.
>>
>> Hint: it can't.  It fails because the temporary donor inode has
>> been deleted and has invalid mode 0 when we try to replay its
>> swapext operation.  Kernel patches to fix it will follow soon.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/tests/xfs/444 b/tests/xfs/444
>> new file mode 100755
>> index 0000000..e88438a
>> --- /dev/null
>> +++ b/tests/xfs/444
>> @@ -0,0 +1,144 @@
> ...
>> +# Test performs several operations to produce a badly fragmented file, then
>> +# create enough contiguous free space for xfs_fsr to defragment the fragmented
>> +# file:
>> +#
>> +# - create fs with 3 minimum sized (16Mb) allocation groups
>> +# - create 16x1MB contiguous files which will become large free space extents
>> +#   when deleted
>> +# - put a small "space" between each of the 16 contiuguous files to ensure we
>> +#   have separated free space extents
>> +# - fill the remaining free space with a "fill file"
>> +# - mount/unmount/fill remaining free space with a pad file
>> +# - punch alternate single block holes in the the "fill file" to create
>> +#   fragmented free space.
>> +# - use fill2 to generate a very large fragmented file
>> +# - delete the 16 large contiguous files created initially
>> +# - run xfs_fsr on the filesystem
>> +# - check checksums for remaining files
>> +
> 
> Without having dug into the core issue, I wonder whether this sequence
> could be simplified a bit by using 'xfs_io -c swapext' followed by a
> shutdown?

I haven't been able to beat xfs_io into submission here; it requires unlinking
as well, and even after patching & adding an unlink into the mix:

xfs_io -x -c "open -f mnt/file1" -c "pwrite 0 4k" -c close -c "open -f mnt/file2" -c "pwrite 0 4k" -c unlink -c "swapext mnt/file1" -c "shutdown -f"

I can't seem to make this reproduce.  Not sure why.  I'd rather just stick with the proven reproducer.

-Eric

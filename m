Received: from sandeen.net ([63.231.237.45]:44375 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbcBSFhl convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 19 Feb 2016 00:37:41 -0500
Received: from [10.0.0.194] (unknown [10.0.0.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id A49D765F7019
	for <fstests@vger.kernel.org>; Thu, 18 Feb 2016 23:37:40 -0600 (CST)
From: Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] test Q_GETNEXTQUOTA
Message-Id: <7AFD56B8-EB74-4176-B915-3AB62F7E6915@sandeen.net>
Date: Thu, 18 Feb 2016 23:37:40 -0600
References: <56A17195.8090400@sandeen.net> <233D920A-E368-4714-B8AB-ABE595AEAD96@sandeen.net>
In-Reply-To: <233D920A-E368-4714-B8AB-ABE595AEAD96@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Ignore that, sorry.  I see Dave committed it.

> On Feb 18, 2016, at 11:35 PM, Eric Sandeen <sandeen@sandeen.net> wrote:
> 
> Ping?
> 
>> On Jan 21, 2016, at 6:02 PM, Eric Sandeen <sandeen@sandeen.net> wrote:
>> 
>> The new Q_GETNEXTQUOTA quotactl (not yet merged) is designed
>> to take an ID as input ala Q_GETQUOTA, and return the quota
>> for the next active ID >= the input ID.  This lets us quickly
>> iterate over all existing quotas by leveraging the kernel's
>> knowledge of which quotas are allocated and active.
>> 
>> The test contains a new helper binary, test-nextquota, which
>> tests both the "vfs" and "xfs" versions of the quotactl.
>> It accepts an ID, and outputs the returned ID, ihard, and
>> isoft values for that quota.  It doesn't return block information
>> simply because that can vary depending on fs, block size, etc,
>> and we want something very consistent as output, for verifiation.
>> 
>> The test harness sets quotas for 100 random IDs, remounts,
>> and uses these quotactls to iterate over all the IDs we set,
>> using the test binary, making sure we get back what we expect.
>> 
>> Not the prettiest thing, but it works!
>> 
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>> 
>> 
>> diff --git a/src/Makefile b/src/Makefile
>> index 4781736..48e6765 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -19,7 +19,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>>   bulkstat_unlink_test_modified t_dir_offset t_futimens t_immutable \
>>   stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
>>   seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
>> -    renameat2 t_getcwd e4compact
>> +    renameat2 t_getcwd e4compact test-nextquota
>> 
>> SUBDIRS =
>> 
>> diff --git a/src/test-nextquota.c b/src/test-nextquota.c
>> new file mode 100644
>> index 0000000..a2bbad9
>> --- /dev/null
>> +++ b/src/test-nextquota.c
>> @@ -0,0 +1,163 @@
>> +/*
>> + * Copyright (c) 2016 Red Hat, Inc.
>> + * All Rights Reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it would be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write the Free Software Foundation,
>> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + */
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include <sys/quota.h>
>> +#include <sys/types.h>
>> +#include <xfs/xqm.h>
>> +
>> +/*
>> + * Exercise the Q_GETNEXTQUOTA and Q_XGETNEXTQUOTA quotactls.
>> + * Really only returns a bare minimum of quota information,
>> + * just enough to be sure we got a sane answer back.
>> + *
>> + * These quotactls take a quota ID as input, and return the
>> + * next active quota >= that ID.
>> + *
>> + * usage:
>> + *    test-nextquota [-v] -[u|g|p] -i id -d device
>> + */
>> +
>> +#ifndef PRJQUOTA
>> +#define PRJQUOTA 2
>> +#endif
>> +
>> +#ifndef Q_GETNEXTQUOTA
>> +#define Q_GETNEXTQUOTA 0x800009        /* get disk limits and usage >= ID */
>> +
>> +struct nextdqblk
>> +  {
>> +    u_int64_t dqb_bhardlimit;    /* absolute limit on disk quota blocks alloc */
>> +    u_int64_t dqb_bsoftlimit;    /* preferred limit on disk quota blocks */
>> +    u_int64_t dqb_curspace;    /* current quota block count */
>> +    u_int64_t dqb_ihardlimit;    /* maximum # allocated inodes */
>> +    u_int64_t dqb_isoftlimit;    /* preferred inode limit */
>> +    u_int64_t dqb_curinodes;    /* current # allocated inodes */
>> +    u_int64_t dqb_btime;    /* time limit for excessive disk use */
>> +    u_int64_t dqb_itime;    /* time limit for excessive files */
>> +    u_int32_t dqb_valid;    /* bitmask of QIF_* constants */
>> +    u_int32_t dqb_id;        /* id for this quota info*/
>> +  };
>> +#endif
>> +
>> +#ifndef Q_XGETNEXTQUOTA
>> +#define Q_XGETNEXTQUOTA XQM_CMD(9)
>> +#endif
>> +
>> +void usage(char *progname)
>> +{
>> +    printf("usage: %s [-v] -[u|g|p] -i id -d device\n", progname);
>> +    exit(1);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +    int c;
>> +    int cmd;
>> +    int type = -1, typeflag = 0;
>> +    int verbose = 0;
>> +    uint id = 0, idflag = 0;
>> +    char *device = NULL;
>> +    struct nextdqblk dqb;
>> +    struct fs_disk_quota xqb;
>> +
>> +    while ((c = getopt(argc,argv,"ugpi:d:v")) != EOF) {
>> +        switch (c) {
>> +        case 'u':
>> +            type = USRQUOTA;
>> +            typeflag++;
>> +            break;
>> +        case 'g':
>> +            type = GRPQUOTA;
>> +            typeflag++;
>> +            break;
>> +        case 'p':
>> +            type = PRJQUOTA;
>> +            typeflag++;
>> +            break;
>> +        case 'i':
>> +            id = atoi(optarg);
>> +            idflag++;
>> +            break;
>> +        case 'd':
>> +            device = optarg;
>> +            break;
>> +        case 'v':
>> +            verbose++;
>> +            break;
>> +        default:
>> +            usage(argv[0]);
>> +        }
>> +    }
>> +
>> +    if (idflag == 0) {
>> +        printf("No id specified\n");
>> +        usage(argv[0]);
>> +    }
>> +    if (typeflag == 0) {
>> +        printf("No type specified\n");
>> +        usage(argv[0]);
>> +    }
>> +    if (typeflag > 1) {
>> +        printf("Multiple types specified\n");
>> +        usage(argv[0]);
>> +    }
>> +    if (device == NULL) {
>> +        printf("No device specified\n");
>> +        usage(argv[0]);
>> +    }
>> +
>> +    if (verbose)
>> +        printf("asking for quota type %d for id %u on %s\n", type, id, device);
>> +
>> +    memset(&dqb, 0, sizeof(struct nextdqblk));
>> +    memset(&xqb, 0, sizeof(struct fs_disk_quota));
>> +
>> +    if (verbose)
>> +        printf("====Q_GETNEXTQUOTA====\n");
>> +    cmd = QCMD(Q_GETNEXTQUOTA, type);
>> +    if (quotactl(cmd, device, id, (void *)&dqb) < 0) {
>> +        perror("Q_GETNEXTQUOTA");
>> +        return 1;
>> +    }
>> +
>> +    /*
>> +     * We only print id and inode limits because
>> +     * block count varies depending on fs block size, etc;
>> +     * this is just a sanity test that we can retrieve the quota,
>> +     * and inode limits have the same units across both calls.
>> +     */
>> +    printf("id        %u\n", dqb.dqb_id);
>> +    printf("ihard     %llu\n", (unsigned long long)dqb.dqb_ihardlimit);
>> +    printf("isoft     %llu\n", (unsigned long long)dqb.dqb_isoftlimit);
>> +
>> +    if (verbose)
>> +        printf("====Q_XGETNEXTQUOTA====\n");
>> +    cmd = QCMD(Q_XGETNEXTQUOTA, USRQUOTA);
>> +    if (quotactl(cmd, device, id, (void *)&xqb) < 0) {
>> +        perror("Q_XGETNEXTQUOTA");
>> +        return 1;
>> +    }
>> +
>> +    printf("id        %u\n", xqb.d_id);
>> +    printf("ihard     %llu\n", xqb.d_ino_hardlimit);
>> +    printf("isoft     %llu\n", xqb.d_ino_softlimit);
>> +
>> +    return 0;
>> +}
>> diff --git a/tests/generic/244 b/tests/generic/244
>> new file mode 100755
>> index 0000000..eb5a5ab
>> --- /dev/null
>> +++ b/tests/generic/244
>> @@ -0,0 +1,131 @@
>> +#! /bin/bash
>> +# FS QA Test 244
>> +#
>> +# test out "sparse" quota ids retrieved by Q_GETNEXTQUOTA
>> +#
>> +# Designed to use the new Q_GETNEXTQUOTA quotactl
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1    # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +    cat $tmp.IDs >> $seqres.full
>> +    cd /
>> +    rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/quota
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_quota
>> +_require_scratch
>> +
>> +scratch_unmount 2>/dev/null
>> +_scratch_mkfs >> $seqres.full 2>&1
>> +_scratch_mount "-o usrquota,grpquota"
>> +quotacheck -u -g $SCRATCH_MNT 2>/dev/null
>> +quotaon $SCRATCH_MNT 2>/dev/null
>> +_scratch_unmount
>> +
>> +TYPES="u g"
>> +MOUNT_OPTIONS="-o usrquota,grpquota"
>> +
>> +_qmount
>> +quotaon $SCRATCH_MNT 2>/dev/null
>> +
>> +# Ok, do we even have GETNEXTQUOTA?  Querying ID 0 should work.
>> +$here/src/test-nextquota -i 0 -u -d $SCRATCH_DEV &> $seqres.full || \
>> +    _notrun "No GETNEXTQUOTA support"
>> +
>> +echo "Launch all quotas"
>> +
>> +# Ideally we'd carefully test edge conditions of "sparse"
>> +# quota ids at beginnings and ends of otherwise empty disk
>> +# blocks, etc, but that's pretty fs-specific.
>> +# So just spray a bunch of random IDs into quota, and make
>> +# sure we get them all back.
>> +
>> +ITERATIONS=100
>> +
>> +# A few extra on the off chance we get dups
>> +for I in `seq 1 $(($ITERATIONS+10))`; do
>> +    ID=`od -N 4 -t uL -An /dev/urandom | tr -d " "`
>> +    echo $ID >> $tmp.1
>> +done
>> +
>> +# sort & uniq to remove dups & facilitate reading them back
>> +# On the off chance we got ID 0, remove it.
>> +sort -n $tmp.1 | uniq | head -n ${ITERATIONS} | grep -vw 0 > $tmp.IDs
>> +
>> +# Populate a bunch of random quotas on the filesystem:
>> +for TYPE in u g; do
>> +    for ID in `cat $tmp.IDs`; do
>> +        setquota -${TYPE} $ID $ID $ID $ID $ID $SCRATCH_MNT
>> +        touch ${SCRATCH_MNT}/${ID}
>> +        chown ${ID} ${SCRATCH_MNT}/${ID}
>> +    done
>> +done
>> +
>> +# remount just for kicks, make sure we get it off disk
>> +_scratch_unmount
>> +_qmount
>> +quotaon $SCRATCH_MNT 2>/dev/null
>> +
>> +# Read them back by iterating based on quotas returned.
>> +# This should match what we set, even if we don't directly
>> +# ask for each exact id, but just ask for "next" id after
>> +# each one we got back last.
>> +for TYPE in u g; do
>> +    # root is always there but not in our random IDs; start at 1
>> +    NEXT=1
>> +    for ID in `cat $tmp.IDs`; do
>> +        echo "Trying ID $NEXT expecting $ID" >> $seqres.full
>> +        Q=`$here/src/test-nextquota -i $NEXT -${TYPE} -d $SCRATCH_DEV` \
>> +             || _fail "test-nextquota failed: $Q"
>> +        echo $Q >> $seqres.full
>> +        # ID and its inode limits should match
>> +        echo "$Q" | grep -qw ${ID} || _fail "Didn't get id $ID"
>> +        # Get the ID returned from the test
>> +        NEXT=`echo "$Q" | grep ^id | awk '{print $NF}' | head -n 1`
>> +        # Advance that ID by one, and ask for another search
>> +        let NEXT=NEXT+1
>> +    done
>> +done
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/244.out b/tests/generic/244.out
>> new file mode 100644
>> index 0000000..df76947
>> --- /dev/null
>> +++ b/tests/generic/244.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 244
>> +Launch all quotas
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 8ed383f..860ff4a 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -246,6 +246,7 @@
>> 241 auto
>> 242 auto quick clone
>> 243 auto quick clone
>> +244 auto quick quota
>> 245 auto quick dir
>> 246 auto quick rw
>> 247 auto quick rw
>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

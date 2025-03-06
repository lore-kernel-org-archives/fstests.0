Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9B207A34
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297169; cv=none; b=Wm6FXs5hZuh8OUsv+GFrVM6+za8DwQYGB4t+dbnwALtxhogp+CHPLRzH/p865wPfzQwf5eYu/9aOyVtQI1sLAEDrZURJU8QZe7Oyf0CBVVFj5DgSi0ZEym1PbbEXqJDWyFh8E5Bk5irdB+R4FuOJj8zrrM17tnYl3HjRKtsNL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297169; c=relaxed/simple;
	bh=iTAkiLhTD7dez0IwrMWxK/DH6Vu6yQhssj3zV0uSpAY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIktZdfkf2O0+rb0AZBtGBqkONOvGAuMnh0uWPMS8nFeNfBK9E+NCBDy2Xv292PGkouP9DXPlz2xWn9aGgkV7hKafHZTVMFBjMhlShU5yYJhKUzL4Y4kyqU/n9BQHkLylpiJj6RCf20wQhKvVa60SNqguw2FOZ8U5+ab+PjJQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1OtHxjsj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1OtHxjsj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224100e9a5cso21837435ad.2
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 13:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741297166; x=1741901966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHQAScpZJLW0kW4Qb3/VRaYbP43fdtprpyU3J1+tFKs=;
        b=1OtHxjsjgDjrTEDAHlJoOYAESFF5Y24pnNyQx2DQd+kaXrSLnjVAmQaPwva8NL0ICD
         T8jCh1Oq9O5H1ErW+4s1yXm4VaT1gLMHO02wHNMR1zEEFe+/fVQz3IGB9dWP7M9ndMKG
         S2ROOWyCFi+HRURLzPPw28eamDPwEW0pZX/iWPHZUNiSQprTSXTfW/2Rn7lzlPqyjaOH
         JF6xOw/sqBI6ZP8/FKBCAN4tt5YqyKBbqzTdonFaRtB47NhHp2aopxH6YQmwS1lRHzpb
         yoDxm5rzuegYX8odgcgyuRvIX829j5cxUaQWgFJTJnxHNwdPdOqoBoT4qF1BP1bomNeF
         dwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297166; x=1741901966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHQAScpZJLW0kW4Qb3/VRaYbP43fdtprpyU3J1+tFKs=;
        b=dB1r3cmTVh62v7zDc9PbTizO3EaouIULslkaJgk6nQMhhUryxqzMiNBNRiriFlm99j
         2lXknwQnQEVtxT9SB01UEahF4N65QwqhG3byGZyvOUwdJQ0/60SsjqEkL1HZGsmo16m7
         CqB/i2SoQWZED+FJu00Ezcr40RK/ICpqfkSRob381rlCAp8W/ydjVjJ+R6jvE+bszJ73
         KyvxOjG8ZQ3G325ZkS41vb76q+EnuHx0uRtcedxebeT/Edg19ps7RhSf8AdKe0CoR+tk
         NvECiqYPMnunGW4y9Qhx45JD8ldNn7qMCB2rR8c0AdfM5LeRmGgoW6QcDbFOyEkjumTp
         /Hqg==
X-Gm-Message-State: AOJu0Yyajr5EgpPM481k7dSw2sZLtzAwU8s6X0me+q5hkvHtOTcN7E5B
	raYd1VIrbxi3ETrRYcfmsUHJkMAPK1qyVVfW3cBOGL5vsH4ZmcbppwGe0SZNrnogVIA7Z8tN/AI
	o
X-Gm-Gg: ASbGncuMuWYU8RLd9d5WwPkSCb4Go3fq081Mc4qVXetvvvtg1lkepuRBsGbgfGjyQek
	vBxmrpOltU9cCysOUbWJ97BJFo/luNVbTvyBhzsvGu6ItevGWL4qf/pzp48bs+ATPqxh0AhNuUV
	GbKu0Os4LzirvLSqU2Fk0AGGVZ0K/9vc4MpUUaUILNKEORDt1jjMOsSd/DCGXtGIyGERN9vFcx6
	owxh7hRJts5YsyP9vfjmNI+UoxasxK2NRjmjQeCl7CYORTCy/xwSPeXm/RBf4B06oH4WLzMBhuP
	UYJNP5CQgP0i1bmXAq0wRLYVTD1S1+z8jm50GMWbl4fYXAdb/A0po2bvbK4WU5Vd1d1BcmrQCvZ
	WG1AsBZesrMS2pMbEt4Y=
X-Google-Smtp-Source: AGHT+IF4RtH7bdrWXrAvFPHazT2iNjkpQ5u2/zh5zTnVC8JfcsyNBfoiOmZp2rMsecZP1tXSnBAdzw==
X-Received: by 2002:a05:6a00:4b4a:b0:736:6ac4:d1ff with SMTP id d2e1a72fcca58-736aa9e7154mr1673484b3a.3.1741297166262;
        Thu, 06 Mar 2025 13:39:26 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736984f7115sm1904388b3a.105.2025.03.06.13.39.25
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:39:25 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tqIw6-00000009lRc-2T6O
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tqIw6-0000000FvrR-3Fvh
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 3/5] fstests: remove crash script
Date: Fri,  7 Mar 2025 08:34:48 +1100
Message-ID: <20250306213921.3769440-4-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306213921.3769440-1-david@fromorbit.com>
References: <20250306213921.3769440-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

This is an old, early 2000s SGI era script for crash and recovery
testing XFS filesystems. We have much better ways of doing this
today with tools like dm-error, dm-flakey, etc. Nobody has been
using this script for years, so remove it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 crash/README     | 151 --------------
 crash/rc.sysinit |  46 -----
 crash/xfscrash   | 506 -----------------------------------------------
 3 files changed, 703 deletions(-)
 delete mode 100644 crash/README
 delete mode 100644 crash/rc.sysinit
 delete mode 100755 crash/xfscrash

diff --git a/crash/README b/crash/README
deleted file mode 100644
index 36f2ec65e..000000000
--- a/crash/README
+++ /dev/null
@@ -1,151 +0,0 @@
-############
-# xfscrash #  crash testing setup for XFS
-############
-
-*** disclaimers ***
-
-    work-in-progress, buyer-beware, your-mileage-may-vary, this-is-a-hack
-
-*** what xfscrash does ***
-
-    xfscrash allows realistic testing of XFS log recovery and XFS check/repair
-    by generating log activity on an XFS partition, then rebooting the machine
-    at a random point. When the machine comes back up, xfscrash is restarted
-    and then tests either the log recovery or xfs_repair on the dirtied
-    filesystem. All going well the process continues.
-
-*** getting ready for crash testing ***
-
-    Most filesystems (ext2 included) can't withstand having the machine
-    they're running on rebooted while they're active. So the crash test
-    machine needs to have all filesystems other than the test FS mounted
-    read-only so they won't get trashed when the machine reboots.
-
-*** mouting FSes read-only ***
-
-    Following is a recipe for making a redhat linux (6.2) machine with a single
-    ext2 FS mounted on root able to be booted read-only. Your Mileage May
-    Vary - don't try this on an important machine.
-
-    The idea is to move anything that needs to be r/w into the /initrd_init
-    directory, replacing the moved directories with links to the moved ones.
-    That way the /initrd_init directory may be copied to a ramdisk, and
-    mounted over /initrd on the root FS which never gets remounted r/w.
-
-        # go to single user
-        init 1
-
-        # make a mount point for the ramdisk
-        mkdir /initrd
-
-        # link across to the /initrd_init directory for when 
-        # the ramdisk isn't mounted
-        ln -s /initrd_init/dev .
-        ln -s /initrd_init/etc .
-        ln -s /initrd_init/proc .
-        ln -s /initrd_init/sbin .
-        ln -s /initrd_init/tmp .
-        ln -s /initrd_init/var .
-
-        # make the /initrd_init directory
-        mkdir /initrd_init
-        cd /initrd_init
-
-
-        # move /dev
-        mv /dev .
-        ln -s /dev /initrd/dev
-
-        # move /etc
-        mv /etc .
-        ln -s /etc /initrd/etc
-
-        # make proc mount
-        mkdir proc 
-
-        # move /tmp
-        mkdir tmp
-        rm -rf /tmp
-        ln -s /tmp /initrd/tmp
-
-        # link /sbin 
-        ln -s /sbin .
-
-        # setup a tree for parts of /var
-        mkdir var var/cache var/lock var/lock/console var/lock/subsys
-        mkdir var/log var/preserve var/run 
-
-        touch /var/run/utmp /var/log/utmp /var/log/wtmp 
-
-        # move parts of /var
-        rm -rf /var/cache /var/lock /var/log /var/preserve /var/run
-        ln -s /initrd/var/cache /var/cache
-        ln -s /initrd/var/lock /var/lock
-        ln -s /initrd/var/log /var/log
-        ln -s /initrd/var/preserve /var/preserve
-        ln -s /initrd/var/run /var/run
-
-        # make a mount for /var/shm
-        mkdir var/shm 
-        ln -s /var/shm /initrd/var/shm
-
-        # move /var/spool
-        mkdir var/spool
-        mkdir var/spool/mail var/spool/anacron var/spool/at var/spool/lpd
-        mkdir var/spool/rwho var/spool/mqueue var/spool/cron
-        rm -rf /var/spool
-        ln -s /var/spool /initrd/var/spool
-
-        # move /var/tmp
-        mkdir var/tmp
-        rm -rf /var/tmp
-        ln -s /var/tmp /initrd/var/tmp
-
-        # trim /dev - too many inodes here - remove anything you don't need
-        # (small ramdisk has a small number of inodes)
-        rm -rf /initrd/dev/<....>   
-
-    All going well, all the directories you've made should link through
-    /initrd and into /initrd_init, and the machine should come back up
-    if you restart it.
-
-    You want to keep the contents of /initrd_init to a minimum because
-    this stuff has to fit into the ramdisk.
-
-*** getting the ramdisk going ***
-
-    See the rc.sysinit file for some details of what to do to get the
-    ro-root/ramdisk up and running.
-
-    Once everything is going, the root FS should never be remounted to
-    r/w on boot and should be in r/o mode when the machine comes up.
-    
-    All going well, any open files have been redirected through the
-    symlinks onto the ramdisk, so you should be able to remount the
-    root FS to r/w and then remount it back to r/o.
-    
-    Since there's no r/w filesystems mounted, it should be ok to 
-    reboot the machine with 'reboot -fn' and everything should come
-    back without dirty filesystems and without having to fsck.
-    
-*** starting xfscrash ***
-
-    The simplest way to restart xfscrash on reboot is to start it
-    in the background from rc.local. The script logs to /dev/tty1,
-    /dev/console & a logfile by default, so the output should be
-    easy to find.
-    
-    Link the xfscrash directory off an NFS mounted FS so you can make
-    changes while the machine is rebooting and so you can touch the
-    'stop' and 'start' control files.
-
-    To configure the system, change the parameters in the configuration
-    section of the 'xfscrash' script.
-    
-    To start the system, touch the 'start' control file and then either
-    reboot or manually run the 'xfscrash' script.
-    
-    To stop the system, touch the 'stop' control file and wait for the
-    next cycle to start when the control file will be checked and
-    the test terminated.
-
diff --git a/crash/rc.sysinit b/crash/rc.sysinit
deleted file mode 100644
index 0f0781a79..000000000
--- a/crash/rc.sysinit
+++ /dev/null
@@ -1,46 +0,0 @@
-#
-# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# xfscrash - control the XFS crash tests
-#
-
-# this is an example of what to add to rc.sysinit on a redhat linux
-# system to get the ro-root/ramdisk system up and running
-
-if [ -f /initrd.active ]
-then
-	echo "*** MAKE RAMDISK ***"
-	dd if=/dev/zero of=/dev/ram0 bs=1024k count=4
-	mkfs -i 1024 /dev/ram0 4096
-	echo "*** MOUNT RAMDISK ***"
-	mount -n -w /dev/ram0 /mnt
-	echo "*** INIT RAMDISK ***"
-	cp -a /initrd_init/* /mnt
-	rm -f /mnt/00_INITRD_REAL
-	touch /mnt/00_INITRD_RAMDISK
-	umount -n /mnt
-	echo "*** REMOUNT RAMDISK ***"
-	mount -n /dev/ram0 /initrd
-
-	echo "*** FIX MTAB ***"
-	>/etc/mtab
-	rm -f /etc/mtab~ /etc/mtab~~
-	mount -f -o ro /
-	mount -f -o rw /dev/ram0 /initrd
-else
-        # old code
-        
-	# Remount the root filesystem read-write.
-	action "Remounting root filesystem in read-write mode" mount -n -o remount,rw /
-
-	# Clear mtab
-	>/etc/mtab
-
-	# Remove stale backups
-	rm -f /etc/mtab~ /etc/mtab~~
-
-	# Enter root and /proc into mtab.
-	mount -f /
-	mount -f /proc
-
-fi
diff --git a/crash/xfscrash b/crash/xfscrash
deleted file mode 100755
index 037b3df1e..000000000
--- a/crash/xfscrash
+++ /dev/null
@@ -1,506 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# xfscrash - control the XFS crash tests
-#
-
-  #######################
-### configuration stuff ########################################################
-  #######################
-
-# remount, repair or corrupt
-MODE=remount
-# where to find xfscrash
-XFSCRASH=/xfscrash
-# put log files here
-LOG=$XFSCRASH
-# put output to these places
-OUTPUT="$LOG/xfscrash.log /dev/tty1 /dev/console"
-# awk...
-AWK_PROG=gawk
-# clear FS if >= this percent full at start of run. 100 is a good
-# number - only used on corrupt test so far
-FULL_LIMIT=80
-  
-case `hostname -s`
-in
-    leesa)
-        # mount test partition here
-        TEST_MNT=/mnt/arch0
-        # build test partition here
-        TEST_DEV=/dev/hda6
-        # backup test partition to here (or empty)
-        BACKUP_DEV=/dev/hda8
-        # backup block size for dd
-        BACKUP_BS=1024k
-        # base stress time
-        STRESS_TIME=60
-        # stress random time
-        STRESS_RANDOM=60
-	;;
-    lumpy)
-        # mount test partition here
-        TEST_MNT=/mnt/scratch_0
-        # build test partition here
-        TEST_DEV=/dev/sdc5
-        # backup test partition to here (or empty)
-        BACKUP_DEV=  ;#/dev/sdc6
-        # backup block size for dd
-        BACKUP_BS=10240k
-        # base stress time
-        STRESS_TIME=360
-        # stress random time
-        STRESS_RANDOM=360
-	;;
-    *)
-        echo "!!! no configuration data for host `hostname -s`"
-        exit 1
-        ;;
-esac
-
-# avoid stress
-
-AVOID="-f resvsp=0 -f unresvsp=0"
-
-# DIY stress command
-STRESS="/usr/local/bin/fsstress -d $TEST_MNT/stress -n 10000000 -p 1 $AVOID"
-#STRESS="/usr/local/bin/randholes -l 10000000 -c 100000 -b 512 $TEST_MNT/stress/holes"
-
-# stress command for the corrupt test
-CORRUPT_STRESS="/usr/local/bin/fsstress -d $TEST_MNT/stress -n 10000 -p 1 $AVOID"
-
-###########################################################################
-
-reboot=-1
-
-_log()
-{
-    tee -a $OUTPUT > /dev/null
-}
-
-_echo()
-{
-    echo "$*" | _log
-}
-
-_mount()
-{
-    _echo "   *** Mounting $TEST_DEV on $TEST_MNT"
-    if ! mount -t xfs $TEST_DEV $TEST_MNT
-    then
-        _echo "   !!! unable to mount"
-        exit 1
-    fi
-}
-
-_unmount()
-{
-    _echo "   *** Unmounting $TEST_DEV"
-    if ! umount $TEST_DEV &> /dev/null
-    then
-        _echo "   !!! unable to unmount"
-        exit 1
-    fi
-}
-
-_check()
-{
-    expect=$1
-    fail=0
-    
-    if [ $expect -eq 0 ]
-    then
-        _echo "      *** xfs_repair -n ($LOG/repair_clean.out)"   
-        xfs_repair -n $TEST_DEV &> $LOG/repair_clean.out || fail=1
-    fi
-    
-    if [ $fail -eq 0 ]
-    then
-        _echo "         *** FS checks ok"
-    else
-        if [ $expect -eq 0 ]
-        then
-            _echo "         !!! FS check failed - inconsistent FS"
-            _echo "         !!! (see $LOG/*.out for details)"
-            exit 1
-        else
-            _echo "         *** inconsistent fs (as expected)"
-        fi
-    fi
-}
-
-_check_core()
-{        
-    if [ -e core ]
-    then
-        _echo "   !!! core file found!"
-        exit 1
-    fi
-}
-
-_repair()
-{
-    rm -f core
-    _echo "   *** repair"
-    _echo "      *** repair pass 1 (RO)"
-    xfs_repair -n $TEST_DEV &> $LOG/repair_1.out \
-        && _echo "         !!! no errors found (eh?)" \
-        || _echo "         *** errors found (expected)"
-        
-    _check_core
-        
-    _echo "      *** repair pass 2 (RW)"
-    
-    if xfs_repair $TEST_DEV &> $LOG/repair_2.out
-    then
-        _echo "         *** FS checks ok (now)"
-    else
-        _echo "         !!! xfs_repair returned error code"
-        _echo "         !!! (see $LOG/repair_*.out for details)"
-        exit 1
-    fi
-        
-    _check_core
-        
-    _echo "      *** repair pass 3 (RO)"
-    if xfs_repair -n $TEST_DEV &> $LOG/repair_3.out
-    then
-        _echo "         *** FS checks ok"
-    else
-        _echo "         !!! errors found after repair (unexpected)"
-        _echo "         !!! (see $LOG/repair_*.out for details)"
-        exit 1
-    fi
-
-    _check_core
-}
-
-_cleanup()
-{
-    rm -f $XFSCRASH/counter $XFSCRASH/start $XFSCRASH/stop $XFSCRASH/active 
-    
-    if [ $reboot != -1 ]
-    then
-        kill $reboot
-    fi
-    
-}
-
-_random()
-{
-    od -tu -N 4 /dev/random | gawk -v v=$1 'NR==1 { print $2 % v }'
-}
-
-_backup()
-{
-    if [ $count -ne 1 -a "$BACKUP_DEV" != "" ]
-    then
-        _echo "   *** Backing up $TEST_DEV to $BACKUP_DEV"
-        if ! dd if=$TEST_DEV of=$BACKUP_DEV bs=$BACKUP_BS &> $LOG/dd.out
-        then
-            _echo "   !!! unable to backup fs"
-            _echo "   !!! (see $LOG/dd.out)"
-            exit 1
-        fi
-    else
-        _echo "   *** skipping back up step"
-    fi
-}
-
-_logprint()
-{
-    _echo "   *** dumping log to $LOG/logprint.out"
-    rm -f core
-    xfs_logprint $TEST_DEV &> $LOG/logprint.out
-    if [ -e core ]
-    then
-        _echo "      !!! xfs_logprint dumped core"
-        echo "" >> $LOG/logprint.out
-        echo "*** CORE DUMPED ***" >> $LOG/logprint.out
-        echo "" >> $LOG/logprint.out
-    fi
-    
-    _echo "   *** dumping log (-t -i) to $LOG/logprint_inode.out"
-    
-    rm -f core
-    xfs_logprint -t -i $TEST_DEV &> $LOG/logprint_inode.out
-    if [ -e core ]
-    then
-        _echo "      !!! xfs_logprint dumped core"
-        echo "" >> $LOG/logprint_inode.out
-        echo "*** CORE DUMPED ***" >> $LOG/logprint_inode.out
-        echo "" >> $LOG/logprint_inode.out
-    fi
-    
-    _echo "   *** dumping log (-t -b) to $LOG/logprint_buf.out"
-    
-    rm -f core
-    xfs_logprint -t -b $TEST_DEV &> $LOG/logprint_buf.out
-    if [ -e core ]
-    then
-        _echo "      !!! xfs_logprint dumped core"
-        echo "" >> $LOG/logprint_buf.out
-        echo "*** CORE DUMPED ***" >> $LOG/logprint_buf.out
-        echo "" >> $LOG/logprint_buf.out
-    fi
-}
-#
-# _df_device : get an IRIX style df line for a given device 
-#
-#       - returns "" if not mounted
-#       - returns fs type in field two (ala IRIX)
-#       - joins line together if split by fancy df formatting
-#       - strips header etc
-#
-
-_df_device()
-{
-    if [ $# -ne 1 ]
-    then
-	echo "Usage: _df_device device" >&2
-	exit 1
-    fi
-    
-    df -T 2> /dev/null | $AWK_PROG -v what=$1 '
-        match($1,what) && NF==1 { 
-            v=$1
-            getline
-            print v, $0
-            exit
-        }
-        match($1,what) {
-            print
-            exit
-        }
-    '
-}
-
-#
-# _df_dir : get an IRIX style df line for device where a directory resides
-#
-#       - returns fs type in field two (ala IRIX)
-#       - joins line together if split by fancy df formatting
-#       - strips header etc
-#
-
-_df_dir()
-{
-    if [ $# -ne 1 ]
-    then
-	echo "Usage: _df_dir device" >&2
-	exit 1
-    fi
-    
-    df -T $1 2> /dev/null | $AWK_PROG -v what=$1 '
-        NR == 2 && NF==1 { 
-            v=$1
-            getline 
-            print v, $0;
-            exit 0
-        }
-        NR == 2 {
-            print;
-            exit 0
-        }
-        {}
-    '
-    # otherwise, nada
-}
-
-# return percentage used disk space for mounted device
-
-_used()
-{
-    if [ $# -ne 1 ]
-    then
-	echo "Usage: _used device" >&2
-	exit 1
-    fi
-    
-    _df_device $1 | $AWK_PROG '{ sub("%", "") ; print $6 }'
-}
-
-_check_free()
-{
-     used=`_used $TEST_DEV`
-
-     if [ $used -ge $FULL_LIMIT ]    
-     then
-         _echo "      *** $used % used on $TEST_DEV - deleting files"
-         rm -rf $TEST_MNT/stress
-     fi
-}       
-
-# loop, stressing, unounting and checking
-# no (expected) rebooting...
-_corrupt()
-{
-    count=0
-    
-    # don't want to restart if we reboot...
-    _cleanup
-    
-    while true
-    do
-
-        if [ -e $XFSCRASH/stop ]
-        then
-            _echo "### XFS Crash stopped "
-            exit 0
-        fi
-
-        _echo "*** run $count"
-        let "count = count + 1"
-        
-        _check 0
-        _mount
-        
-        _check_free
-        
-        $CORRUPT_STRESS | _log
-        
-        _unmount        
-    done
-}
-
-###########################################################################
-    
-_echo ""
-_echo ""
-echo "XFSCRASH [output to $OUTPUT]"
-_echo ""
-
-if [ "$1" = "start" ]
-then
-    touch $XFSCRASH/start
-fi
-
-if [ "$1" = "stop" ]
-then
-    touch $XFSCRASH/stop
-fi
-
-
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-
-if [ -e $XFSCRASH/stop ]
-then
-    _echo "### XFS Crash stopped "
-    exit 0
-fi
-
-if [ -e $XFSCRASH/start ]
-then
-    _echo "### XFS Crash started "
-    _cleanup
-    rm -f $LOG/*.out $LOG/*.log core
-    
-    touch $XFSCRASH/active
-
-    _echo "   *** Building fresh XFS FS"
-    umount $TEST_DEV &> /dev/null
-    if ! mkfs -t xfs -f $TEST_DEV &> $LOG/mkfs.out
-    then
-        _echo "   !!! unable to mkfs"
-        _echo "   !!! (see $LOG/mkfs.out)"
-        exit 1
-    fi
-fi
-
-if [ ! -e $XFSCRASH/active ]
-then
-    _echo "### XFS Crash inactive "
-    exit 0
-fi
-
-
-if [ -r $XFSCRASH/counter ]
-then
-    count=`cat $XFSCRASH/counter`
-else
-    count=0
-fi
-_echo "### Crash test run $count (mode=$MODE, log=$LOG/{*.out,*.log})"
-
-let "count = count +1"
-echo $count > $XFSCRASH/counter
-
-# real test starts here
-
-_echo "   *** Checking for R/O root"
-if ! mount | grep "on / type" | grep -q "(ro)"
-then
-    _echo "   !!! root not mounted readonly"
-    exit 1
-fi
-
-_echo "   *** Loading XFS modules"
-if ! modprobe xfs
-then
-    _echo "   !!! unable to modprobe xfs"
-    exit 1
-fi
-
-_echo "   *** Unmounting $TEST_DEV"
-umount $TEST_DEV &> /dev/null
-
-_logprint
-if [ $MODE != "corrupt" ]
-then
-    _backup
-fi
-
-case $MODE
-in
-    remount)
-        _check 1 # expect errors
-        _mount
-        _unmount
-	;;
-    repair)
-        _repair
-	;;
-    corrupt)
-        _corrupt
-        exit 0
-        ;;
-    *)
-	_echo "xfscrash: MODE must be remount or repair"
-	exit 1
-	;;
-esac
-
-_check 0 # don't expect errors
-_mount
-
-_echo "   *** Cleaning XFS FS"
-if ! rm -rf $TEST_MNT/stress $TEST_MNT/lost+found &> $LOG/clean.out
-then
-    _echo "   !!! unable to clean XFS FS"
-    _echo "   !!! (see $LOG/clean.out)"
-    exit 1
-fi
-
-_echo "   *** Making stress directory"
-if ! mkdir $TEST_MNT/stress
-then
-    _echo "   !!! unable to mkdir stress"
-    exit 1
-fi
-
-let "bang = STRESS_TIME + `_random $STRESS_RANDOM`"
-
-_echo "   *** Preparing random reboot (in $bang seconds)"
-(
-    sleep $bang
-    _echo "      *** BANG ****"
-    reboot -fn
-) &
-reboot=$!
-
-_echo "   *** Causing stress & waiting for the inevitable"
-$STRESS | _log
-
-exit 0
-- 
2.45.2

